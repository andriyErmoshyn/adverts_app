class Ad < ActiveRecord::Base
  belongs_to :member
  has_many :comments, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  mount_uploader :ad_image, ImageUploader

  validates :ad_content, presence: true
  validate :image_size

  def self.search(search)
    joins([:member]).where("login LIKE ? OR ad_content LIKE ? OR address LIKE ?",
                                           "%#{search}%", "%#{search}%", "%#{search}%")
  end
  
  private

    def image_size
      if ad_image.size > 3.megabytes
        errors.add(:ad_image, "should be less than 3 MB")
      end
    end
end
