class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  include Gravtastic
  gravtastic
  is_gravtastic :email, :rating => 'PG', :default => 'identicon', :size => 128
  include Rails.application.routes.url_helpers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :current_password, :picture, :slug, :public
  attr_accessor :current_password
  has_attached_file :picture, :style => { :large => "100x100", :thumb => "40x40"}


  before_save { |user| user.email = email.downcase }

  validates :name, presence: true, length: { minimum: 3}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates_uniqueness_of :email
  validates_format_of :password, :with => /^(?=.*[\d\W])(?=.*([a-z]|[A-Z]))([\x20-\x7E]){6,}$/, :on => :create
  validates_format_of :password, :with => /^(?=.*[\d\W])(?=.*([a-z]|[A-Z]))([\x20-\x7E]){6,}$/, :on => :update,  allow_blank: true
  validates_confirmation_of :password

  has_many :authentications
  has_one :avatar

  def apply_omniauth(omniauth)
    provider = omniauth['provider']
    self.email = omniauth['info']['email'] if email.blank?
    self.name = omniauth['info']['name']
    authentications.build(:provider => provider, :uid => omniauth['uid'], :token => omniauth['credentials']['token'] ? omniauth['credentials']['token'] : "")
  end

  def set_uuid_pwd
    pwd = UUIDTools::UUID.timestamp_create
    self.password = pwd
    self.password_confirmation = pwd
    nil
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end

  def password_require?
    if self.new_record?
      authentications.empty?
    else
      true
    end
  end

  def avatar_img_url
    if avatar
      self.avatar.image_url
    else
      self.gravatar_url
    end
  end

  def to_jq_upload
    {

        "name" => read_attribute(:picture_file_name),
        "size" => read_attribute(:picture_file_size),
        "thumbnail_url" => self.picture.url(:large),
        "delete_url" => "/change_picture/#{self.id}",
        "delete_type" => "DELETE"
    }
  end

end
