class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 300 }
  validates :address, presence: true, uniqueness: true

  validate :check_address

  # 北部九州のスポットかのチェック
  def check_address
    northern_kyushu_addresses = ["福岡県", "佐賀県", "長崎県", "熊本県", "大分県"]
    unless northern_kyushu_addresses.include?(self.address)
      errors.add(:base, "は北部九州の住所を入力してください")
    end
  end
end
