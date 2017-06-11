class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :favorites
  has_many :users, through: :favorites, source: :user

  before_validation :generate_friendly_id, :on => :create

   def to_param
     self.friendly_id
   end

  protected

   def generate_friendly_id
     self.friendly_id ||= SecureRandom.uuid
   end

end
