class User < ActiveRecord::Base
require 'digest/md5'
  before_save :encrypt_password

  mount_uploader :image, ImageUploader
  validates :name,
    presence: true,
    length: { minimum: 4, allow_blank: true}

  validates_uniqueness_of :name
  
  validates :password,
    presence: true,
    length: {minimum: 6, allow_blank: true},
    confirmation: true

  validates :password_confirmation,
    presence: true

  def encrypt_password
    self.password = Digest::MD5.hexdigest(password)
    
  end

  def self.validate_login(name,password)
    user = User.find_by_name(name)
    if user && user.password == Digest::MD5.hexdigest(password)
      user
    else
      nil
    end
  end
end
