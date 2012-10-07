class User < ActiveRecord::Base
  rolify

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  # Save history
  has_paper_trail

  # validations
  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of :roles

  # authenticate first user as admin or set default role to editor
  before_validation :first_user_hook

private
  # If created user is first user, then make it an admin user
  def first_user_hook
    if User.with_role(:admin).count == 0
      self.grant :admin
    else # set editor as default role
      self.grant :editor if self.roles.empty?
    end
  end
end
