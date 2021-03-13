class User < ApplicationRecord
  has_secure_password

  '''PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x'''

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  '''validates :password, 
    presence: true,  
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :create
  end'''

  validates :password, presence: true
  validate :password_length
  validate :password_lower_case
  validate :password_upper_case
  validate :password_special_char
  validate :password_contains_number

  def password_length
    return if password.length > 7
    errors.add :password, 'must contain at least 8 characters'
  end

  def password_lower_case
    return if !!password.match(/\p{Lower}/)
    errors.add :password, 'must contain at least 1 lowercase'
  end

  def password_upper_case
    return if !!password.match(/\p{Upper}/)
    errors.add :password, 'must contain at least 1 uppercase'
  end

  def password_special_char
    special = "?<>',?[]{}=-)(*&^%$#@`~!"
    regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
    return if password =~ regex
    errors.add :password, 'must contain special character'
  end

  def password_contains_number
    return if password.count("0-9") > 0
    errors.add :password, 'must contain at least one number'
  end

end
