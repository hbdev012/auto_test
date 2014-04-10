class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

## Associations
  belongs_to :company
  has_many   :invitations, :dependent => :destroy

## Constants
  ROLES = %w[admin]

## Fields
  field :first_name
  field :job_title
  field :last_name
  field :role

## Attributes
  attr_accessor   :skip_confirmation
  attr_accessible :first_name, :last_name,
                  :email,
                  :password, :password_confirmation,
                  :remember_me,
                  :company_attributes,
                  :terms,
                  :job_title

## Validations
  with_options :presence => true do |user|
    user.validates :first_name
    user.validates :last_name
    user.validates :job_title
  end

  validates :email, :uniqueness => { :case_sensitive => false }
  validates :role,  :inclusion  => ROLES, :allow_blank => true
  validates :terms, :acceptance => true

## Instance Methods
  def has_role!(role_name)
    self.role = role_name.to_s
    self.save!
  end

  def has_role?(role_name)
    self.role.include?(role_name.to_s)
  end

  def company_creator?
    self.company.creator_id == self.id
  end

  def name
    "#{first_name} #{last_name}"
  end

  def to_email_recipient
    "#{self.name} <#{self.email}>"
  end

protected

  # Devise callback to overwrite if confirmation is required or not.
  def confirmation_required?
    !confirmed? and !skip_confirmation
  end

end
