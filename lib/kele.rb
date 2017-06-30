require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def authentication_token
    options = {"email": @email, "password": @password}
    self.class.post('/sessions', options)
  end
end
