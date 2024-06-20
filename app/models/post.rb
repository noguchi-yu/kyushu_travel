class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 300 }
  validates :address, presence: true, uniqueness: true
  validates :images, length: { maximum: 3, message: '写真は3枚までしかアップロードできません' }

  validate :check_address
  validate :validate_address

  geocoded_by :address
  after_validation :geocode

  mount_uploaders :images, ImageUploader

  # 北部九州のスポットかのチェック
  def check_address
    unless self.address.match?(/\A(?:福岡県|佐賀県|長崎県|熊本県|大分県)/)
      errors.add(:base, "住所は 福岡県|佐賀県|長崎県|熊本県|大分県 から始まるものを入力してください")
    end
  end

  # 住所が存在するかのチェック
  def validate_address
    geocoded = Geocoder.search(address)
    return if geocoded&.first&.coordinates.present?

    errors.add(:address, '住所が存在しません')
  end
end
