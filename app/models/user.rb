require 'digest/sha1'

class User < ActiveRecord::Base
  validates_presence_of :name, :password, :password_confirmation
  validates_confirmation_of :password

  attr_accessible :name, :password, :password_confirmation

  attr_accessor :password

  def password=(pass)
    @password=pass
    self.hashed_password = User.encrypt(@password, 'salty string')
  end

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

end
