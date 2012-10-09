class Menu < ActiveRecord::Base
  # model extension
  acts_as_ordered_tree

  # relations
  has_one :page, :inverse_of => :menu

  # mass assignment
  attr_accessible :title, :position, :parent_id

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
