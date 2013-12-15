class Document < ActiveRecord::Base
  # model extension
  mount_uploader :file, DocumentUploader

  # relations
  belongs_to :page

  # mass assignment
  attr_accessible :title, :file, :file_cache, :remove_file, :remote_file_url, :page_id

  # validations
  before_validation :default_title
  before_validation :strip_whitespaces

  validates_presence_of :title
  validates_uniqueness_of :title, :case_sensitive => false

  # copy to public directory
  before_save :copy_to

  # enable history
  has_paper_trail

  # scopes
  def self.external
    where('page_id is not null')
  end

  # class methods
  def self.deploy
    # remove old files
    external_dir = File.join([Rails.public_path, ActiveModel::Naming.plural(self)].compact)
    FileUtils.rm_rf(Dir[File.join([external_dir, '[^.]*'])])

    # copy current files
    self.external.each do |document|
      document.copy_to
    end
  end

  # instance methods
  def export_filename
    (self.title.gsub(/\s+/, '_') + '.pdf').asciify(Picture.asciify_map) unless self.title.blank?
  end

  def external_url
    File.join('', [ActiveModel::Naming.plural(self.class), self.page.slug, self.export_filename].compact) unless self.title.blank?
  end

  def copy_to
    unless(self.page.blank?) then
      external_filename = File.join([Rails.public_path, self.external_url].compact)

      self.file.file.copy_to(external_filename)
      # self.file.file.move_to(external_filename)
    end
  end

  private
    def default_title
      self.title ||= File.basename(file.filename, '.*').titleize if file
    end

    def strip_whitespaces
      self.title.squish! unless self.title.blank?
    end
end
