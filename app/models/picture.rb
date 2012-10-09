class Picture < ActiveRecord::Base
  # model extension
  mount_uploader :image, ImageUploader

  # relations
  belongs_to :gallery, :inverse_of => :pictures
  acts_as_list :scope => :gallery

  # mass assignment
  attr_accessible :title, :gallery_id, :image, :image_cache, :remove_image, :remote_image_url

  # validations
  before_validation :strip_whitespaces

  validates_presence_of :title
  validates_uniqueness_of :title, :case_sensitive => false

  # enable history
  has_paper_trail

  private
    def strip_whitespaces
      self.title.strip! unless self.title.blank?
    end
end
