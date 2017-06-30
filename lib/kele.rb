gem 'httparty', '~> 0.13'
require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
    @parsed_response = JSON.parse(authentication_token.body, symbolize_names: true)
    unless @parsed_response[:message]
      @auth_token = @parsed_response[:auth_token]
      print "Authentication successful."
    else
      print "Your password or email is invalid."
    end
  end

  def authentication_token
    options = {"email" => @email, "password" => @password}
    self.class.post('/sessions', :body => options)
  end
end
