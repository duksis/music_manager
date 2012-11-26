require 'digest/sha1'

class User < ActiveRecord::Base
  validates_presence_of :name, :password, :password_confirmation
  validates_confirmation_of :password

  attr_accessible :name, :password, :password_confirmation

  attr_accessor :password

  @@salt = 'salty string'

  def password=(pass)
    @password=pass
    self.hashed_password = User.encrypt(@password, @@salt)
  end

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.authenticate(login, password)
    return unless (user = find_by_name(login))
    user if User.encrypt(password, @@salt) == user.hashed_password
  end

end
