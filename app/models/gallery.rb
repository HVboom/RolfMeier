class Gallery < ActiveRecord::Base
  # relations
  has_many :pictures, :order => 'position', :inverse_of => :gallery
  belongs_to :page, :inverse_of => :gallery

  # mass assignment
  attr_accessible :name, :page_id
  accepts_nested_attributes_for :pictures

  # validations
  before_validation :strip_whitespaces

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  # enable history
  has_paper_trail

  private
    def strip_whitespaces
      self.name.strip! unless self.name.blank?
    end
end
