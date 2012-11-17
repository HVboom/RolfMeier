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
  validate :only_2_menu_levels

  # enable history
  has_paper_trail

  private
    def only_2_menu_levels
      # the parent is itself not a child and there is and parent
      errors.add(:parent, "only 2 levels are allowed") unless (self.parent.nil? || self.parent.root?)
    end

    def strip_whitespaces
      self.title.strip! unless self.title.blank?
    end
end
