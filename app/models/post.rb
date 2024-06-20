class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 300 }
  validates :address, presence: true, uniqueness: true
  validates :images, length: { maximum: 3, message: '写真は3枚までしかアップロードできません' }

  validate :check_address
  validate :validate_address

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  mount_uploaders :images, ImageUploader

  # 北部九州のスポットかのチェック
  def check_address
    northern_kyushu_addresses = ["福岡県", "佐賀県", "長崎県", "熊本県", "大分県"]
    unless northern_kyushu_addresses.any? { |addr| self.address.include?(addr) }
      errors.add(:base, "北部九州の住所を入力してください")
    end
  end

  # 住所が存在するかのチェック
  def validate_address
    geocoded = Geocoder.search(address)
    return if geocoded&.first&.coordinates.present?

    errors.add(:address, '住所が存在しません')
  end
end
