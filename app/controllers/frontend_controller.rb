class FrontendController < ApplicationController
   
  helper_method :current_user 
  helper_method :is_guest_user? 
  helper_method :guest_user 

  def current_user
    super || guest_user
  end
  
  def is_guest_user?
    current_user.is_guest? 
  end

  private

  def guest_user
    if  session[:guest_user_id].nil?
       session[:guest_user_id] = create_guest_user.id 
       User.find( session[:guest_user_id] )  
    else
      object = User.find( session[:guest_user_id])
      if object.nil? 
        session[:guest_user_id] = create_guest_user.id 
        User.find( session[:guest_user_id] )  
      end
    end
    # User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  end

  def create_guest_user
    user = User.new { |user| user.guest = true }
    user.email = "guest_#{Time.now.to_i}#{rand(99)}@example.com"
    user.is_guest = true 
    user.save(:validate => false)
    user
  end
end
 