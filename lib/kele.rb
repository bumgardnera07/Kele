require 'httparty'
require 'json'
require 'roadmap.rb'

class Kele
    include HTTParty
    include JSON
    include Roadmaps
    
    def initialize(email, password)
        options = {
            body: {
                    "email": email,
                    "password": password 
                }
        }
        @email = email
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
        @user_data = JSON.parse(response.body)
    end
    
    def get_mentor_availability()
        @mentor_id = @user_data["current_enrollment"]["mentor_id"]
        url = @uri + "/mentors/#{@mentor_id}/student_availability"
        response = self.class.get(url, headers: { "authorization" => @auth_token})
        JSON.parse(response.body)
    end
    
    def get_messages(page=nil)
        url = @uri + "/message_threads"
        if page == nil
            response = self.class.get(url, headers: { "authorization" => @auth_token })
        else
            response = self.class.get(url, headers: { "authorization" => @auth_token }, body: { "page" => page})
        end
        JSON.parse(response.body)
    end
    
    def create_message(subject, messagetext, threadtoken=nil)
        options = {
            headers:{"authorization" => @auth_token},
            
            body: {
                    "sender": @email,
                    "recipient_id": @mentor_id,
                    "token": threadtoken,
                    "subject": subject,
                    "stripped-text": messagetext
                }
        }
        self.class.post(@uri + '/messages', options)
    end
end