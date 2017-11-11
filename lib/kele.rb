require 'httparty'

class Kele
    include HTTParty
    
    def initialize(email, password)
        options = {
            body: {
                    "email": email,
                    "password": password 
                }
        }
        @uri = 'https://www.bloc.io/api/v1'
        @response = self.class.post(@uri + '/sessions', options)
        @auth_token = @response.parsed_response["auth_token"]
        
        if @auth_token == nil
            puts "invalid credentials, please try again"
        else 
            puts "you're in"
        end
    end
end