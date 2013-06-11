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

  # copy to public directory
  after_save :publish

  # enable history
  has_paper_trail

  # scopes
  scope :newest, order('updated_at desc')
  scope :unassigned, where(:gallery_id => nil).newest
  def self.assigned(gallery_id)
    where("gallery_id = ?", gallery_id)
  end
  def self.external
    where('gallery_id is not null').joins(:gallery).merge(Gallery.external)
  end


  # class methods
  def self.deploy
    # remove old files
    external_dir = File.join([Rails.public_path, ActiveModel::Naming.plural(self)].compact)
    FileUtils.rm_rf(Dir[File.join([external_dir, '[^.]*'])])

    # copy current files
    self.external.each do |picture|
      picture.copy_to
    end
  end

  # instance methods
  def export_filename
    ([self.gallery.name, "%02d" % self.position].join(' ').titleize.gsub(/\s+/, '_') + '.jpg') unless self.title.blank?
  end

  def external_url(version)
    unless self.title.blank? and self.gallery.page.blank? then
      File.join('', [ActiveModel::Naming.plural(self.class), self.gallery.page.slug, version.to_s, self.export_filename].compact)
    end
  end

  def copy_to
    unless self.title.blank? or self.gallery.blank? or self.gallery.page.blank? then
      # copy orginal
      external_filename = File.join([Rails.public_path, self.external_url(nil)].compact)
      self.image.file.copy_to(external_filename)

      # copy all versions
      self.image.versions.keys.each do |version|
        external_filename = File.join([Rails.public_path, self.external_url(version)].compact)
        self.image.versions[version].file.copy_to(external_filename)
      end
    end
  end

  private
    def default_title
      self.title ||= File.basename(image.filename, '.*').titleize if image
    end

    def strip_whitespaces
      self.title.strip! unless self.title.blank?
    end

    def crop
      if crop_x.present?
        image.recreate_versions!
        self.copy_to
      end
    end

    def publish
      Rails.logger.debug "Picture - Changed attributes #{self.changes.inspect}"

      Gallery.find(self.gallery_id_was).copy_to if self.gallery_id_changed? and self.gallery_id_was
      unless self.gallery.blank? then
        self.gallery.copy_to if self.position_changed? or self.gallery_id_changed?
      end
    end
end
