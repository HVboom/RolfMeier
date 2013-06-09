class Gallery < ActiveRecord::Base
  # relations
  has_many :pictures, :order => 'position', :inverse_of => :gallery
  belongs_to :page, :inverse_of => :gallery

  # mass assignment
  attr_accessible :name, :page_id
  accepts_nested_attributes_for :pictures

  # callback to copy pictures to the public location
  after_save :cleanup_page, :publish

  # validations
  before_validation :strip_whitespaces

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  # enable history
  has_paper_trail

  # scopes
  def self.external
    where('page_id is not null')
  end

  def copy_to
    ActsAsList.reorder_positions!(self.pictures)
    self.pictures.each do |picture|
      picture.copy_to
    end
  end

  private
    def strip_whitespaces
      self.name.strip! unless self.name.blank?
    end

    def cleanup_page
      Rails.logger.debug "Gallery - cleanup_page #{self.inspect}"

      unless self.page.blank? then
        # get all other galleries having the same page assigned
        Gallery.where(:page_id => self.page).where("id != ?", self.id).each do |gallery|
          gallery.page = nil
          gallery.save
        end
      end
    end

    def publish
      Rails.logger.debug "Gallery - Changed attributes #{self.changes.inspect}"

      self.copy_to if !self.page.blank? and self.page_id_changed?
    end
end
