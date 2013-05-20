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

  # enable history
  has_paper_trail

  def export_filename
    (self.title.gsub(/\s+/, '_') + '.pdf') unless self.title.blank?
  end

  private
    def default_title
      self.title ||= File.basename(file.filename, '.*').titleize if file
    end

    def strip_whitespaces
      self.title.squish! unless self.title.blank?
    end
end
