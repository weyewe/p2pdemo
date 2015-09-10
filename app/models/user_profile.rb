class UserProfile < ActiveRecord::Base
    belongs_to :user 
    
    def self.populate_from_facebook( auth_info, user_object )
        new_object = self.new 
        new_object.user_id = user_object.id 
        
        
        new_object.first_name = auth_info.first_name
        new_object.last_name = auth_info.last_name 
        new_object.fb_profile_image_url = auth_info.image
        
        facebook_url = nil 
        if not  auth_info.urls.nil?
            facebook_url = auth_info.urls.Facebook 
        end
        
        new_object.app_specific_facebook_url =  facebook_url
        
        new_object.save 
    end
    
    def update_object( params ) 
        
        self.first_name = params[:first_name]
        self.last_name = params[:last_name]
        self.save 
    end
end
