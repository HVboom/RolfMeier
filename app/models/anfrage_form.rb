# encoding: utf-8

class AnfrageForm
  # see http://railscasts.com/episodes/219-active-model
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :vorname
  attr_accessor :nachname
  attr_accessor :email
  attr_accessor :mitteilung

  validates_presence_of :nachname, :message => 'Bitte Ihren Namen eingeben'
  validates_presence_of :email, :message => 'Bitte Ihre E-Mail Adresse eingeben'
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => 'Bitte eine gültige E-Mail Adresse eingeben'
  validates_presence_of :mitteilung, :message => 'Bitte schreiben Sie eine Mitteilung'
  validates_length_of :mitteilung, :maximum => 500, :message => 'Bitte beschränken Sie sich auf 500 Zeichen'

  def persisted?
    false
  end
end

