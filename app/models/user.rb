class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, uniqueness: true

  has_many :posts
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post

  # 自分の投稿か確認
  def own_post?(post)
    post.user_id == id
  end

  # ブックマークに追加
  def bookmark(post)
    bookmark_posts << post
  end

  # ブックマークから削除する
  def unbookmark(post)
    bookmark_posts.destroy(post)
  end

  # ブックマーク中か確認
  def bookmark?(post)
    bookmark_posts.include?(post)
  end
end
