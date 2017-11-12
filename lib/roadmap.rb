module Roadmaps
    def get_roadmap(roadmap_id)
        url = @uri + "/roadmaps/#{roadmap_id}"
        response = self.class.get(url, headers: { "authorization" => @auth_token })
        JSON.parse(response.body)
    end
    
    def get_checkpoint(checkpoint_id)
        url = @uri + "/checkpoints/#{checkpoint_id}"
        response = self.class.get(url, headers: { "authorization" => @auth_token })
        JSON.parse(response.body)
    end
end