require 'httparty'
require 'json'

class Kele
    include HTTParty
    include JSON
    
    def initialize(email, password)
        options = {
            body: {
                    "email": email,
                    "password": password 
                }
        }
        @uri = 'https://www.bloc.io/api/v1'
        response = self.class.post(@uri + '/sessions', options)
        @auth_token = response.parsed_response["auth_token"]
        
        if @auth_token == nil
            puts "invalid credentials, please try again"
        else 
            puts "you're in"
        end
    end
    
    def get_me
        url = @uri + "/users/me"
        response = self.class.get(url, headers: { "authorization" => @auth_token })
        JSON.parse(response.body)
    end
end