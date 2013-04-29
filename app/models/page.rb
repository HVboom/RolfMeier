class Page < ActiveRecord::Base
  # relations
  has_one :gallery, :inverse_of => :page
  has_many :pictures, :through => :gallery
  belongs_to :menu, :inverse_of => :page

  # mass assignment
  attr_accessible :title, :slug, :short_text, :long_text, :maintainer, :content_type, :content, :address, :menu_id
  attr_accessible :gallery_attributes
  accepts_nested_attributes_for :gallery, :allow_destroy => true
  accepts_nested_attributes_for :pictures
  # attr_accessible :gallery, :gallery_id

  # model extension
  # enable user friendly URLs
  extend FriendlyId
  friendly_id :title, use: :slugged

  # enable Google maps
  acts_as_gmappable :process_geocoding => :geocode?,
    :address => 'address',
    :normalized_address => 'address',
    :language => 'de'


  # validation is automatically done
  values_for :content_type,
    :has => [ :slide_show, :text, :formular, :map ],
    :add => [ :named_scopes, :predicate_methods ],
    :prefix => nil
  #, :allow_nil => true

  values_for :maintainer,
    :has => [ :editor, :specialist ],
    :add => [ :named_scopes, :predicate_methods ],
    :prefix => nil
  #, :allow_nil => true

  # setup default values
  default_value_for :content_type, :slide_show
  default_value_for :maintainer, :editor


  # cleanup input values of mandatory fields
  before_validation :strip_whitespaces

  # validations of mandatory fields
  validates_presence_of :title
  validates_uniqueness_of :title, :case_sensitive => false

  # validations of mandatory enumeration fields (even, if it is done by values_for)
  validates_presence_of :content_type
  validates_presence_of :maintainer


  # enable history
  has_paper_trail

  # scopes via class methods
  def self.contact
    find_by_slug('anfrage')
  end

  def self.impressum
    find_by_slug('impressum') || contact
  end


  private
    def strip_whitespaces
      self.title.strip! unless self.title.blank?
    end

    def geocode?
      (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
    end

end
