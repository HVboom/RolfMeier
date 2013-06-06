class Gallery < ActiveRecord::Base
  # relations
  has_many :pictures, :order => 'position', :inverse_of => :gallery
  belongs_to :page, :inverse_of => :gallery

  # mass assignment
  attr_accessible :name, :page_id
  accepts_nested_attributes_for :pictures

  # callback to copy pictures to the public location
  after_save :copy_to

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

  def copy_to(force = false)
    Rails.logger.debug "Gallery - Changed attributes #{self.changes.inspect}"

    if !self.page.blank? and (force or self.page_id_changed?) then
      ActsAsList.reorder_positions!(self.pictures)
      self.pictures.each do |picture|
        picture.copy_to
      end
    end
  end

  private
    def strip_whitespaces
      self.name.strip! unless self.name.blank?
    end
end
