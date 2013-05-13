class Picture < ActiveRecord::Base
  # model extension
  mount_uploader :image, ImageUploader

  # needed to crop picture thumbnail
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop

  # relations
  belongs_to :gallery, :inverse_of => :pictures
  acts_as_list :scope => :gallery

  # mass assignment
  attr_accessible :title, :gallery_id, :image, :image_cache, :remove_image, :remote_image_url, :position
  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h

  # validations
  before_validation :default_title
  before_validation :strip_whitespaces

  validates_presence_of :title
  validates_uniqueness_of :title, :case_sensitive => false

  # enable history
  has_paper_trail

  # scopes
  scope :newest, order('updated_at desc')
  scope :unassigned, where(:gallery_id => nil).newest
  def self.assigned(gallery_id)
    where("gallery_id = ?", gallery_id)
  end

  private
    def default_title
      self.title ||= File.basename(image.filename, '.*').titleize if image
    end

    def strip_whitespaces
      self.title.strip! unless self.title.blank?
    end

    def crop
      image.recreate_versions! if crop_x.present?
    end
end
