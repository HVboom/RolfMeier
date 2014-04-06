class Page < ActiveRecord::Base
  # relations
  has_one :gallery, :inverse_of => :page
  has_many :pictures, :through => :gallery, :order => :position
  belongs_to :menu, :inverse_of => :page
  has_many :documents

  # mass assignment
  attr_accessible :title, :slug, :short_text, :long_text, :maintainer, :content_type, :content, :address, :menu_id
  attr_accessible :gallery_attributes
  accepts_nested_attributes_for :gallery, :allow_destroy => true
  accepts_nested_attributes_for :pictures
  accepts_nested_attributes_for :documents
  # attr_accessible :gallery, :gallery_id

  # model extension
  # enable user friendly URLs
  extend FriendlyId
  friendly_id :title, :use => :slugged

  # enable Google maps
  geocoded_by :address
  #acts_as_gmappable :process_geocoding => :geocode?,
    #:address => 'address',
    #:normalized_address => 'address',
    #:language => 'de',
    #:validation => false


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

  # reset geocode attributes, if address is blank
  before_save :geocode, :reset_geocode

  # callback to copy pictures to the public location
  after_save :publish

  # enable history
  has_paper_trail

  # scopes via class methods
  def self.contact
    find_by_slug('anfrage')
  end

  def self.impressum
    find_by_slug('impressum') || contact
  end

  # class methods
  def self.deploy(host =  "rm.dev.hvboom.org", index_page = self.contact.id)
    # iterate through all pages
    self.all.each do |page|
      url = Rails.application.routes.url_helpers.page_url(page, :host => host, :format => :html)
      # silent, because it is only use to refresh the pages in the cache directory
      cmd = "curl --fail --output /dev/null --silent --show-error --location --url #{url}"
      logger.info "#{cmd}"
      errorMsg = `#{cmd}`
      if $?.success? then
        logger.info "  ==> OK"
      else
        logger.warn "  ==> Error: #{errorMsg} from #{cmd}"
      end
    end

    # create index.html
    index_page_filename = File.join([Rails.public_path, ActiveModel::Naming.plural(self), "#{Page.find(index_page).slug}.html"].compact)
    index_filename = File.join([Rails.public_path, "index.html"].compact)
    logger.info "set index.html => #{index_page_filename}"
    FileUtils.cp(index_page_filename, index_filename, :preserve => true)
  end

  private
    def strip_whitespaces
      self.title.strip! unless self.title.blank?
    end

    def reset_geocode
      if self.address.blank? then
        self.address = nil
        self.latitude = nil
        self.longitude = nil
      end
    end

    def geocode?
      (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
    end

    def publish
      Rails.logger.debug "Page - Changed attributes #{self.changes.inspect}"

      # copy assigned pictures to a new location or with new names
      unless self.gallery.blank? then
        self.gallery.copy_to if self.slug_changed? # or self.gallery_id_changed?
      end

      # copy assigned attachments to a new location
      if self.slug_changed? then
        self.documents.each do |document|
          document.copy_to
        end
      end
    end

    # customized slug to remove umlaute, e.g. ö => oe
    def normalize_friendly_id(title)
      super(title.asciify(Picture.asciify_map))
    end
end
