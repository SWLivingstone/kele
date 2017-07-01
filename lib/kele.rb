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

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body, symbolize_names: true)
  end
end
