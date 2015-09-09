class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :fb_current_connection

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  def fb_current_connection
    identity = current_user.identities.where(provider: "facebook").first
    if identity
      @graph = Koala::Facebook::API.new(identity.access_token, FACEBOOK_CONFIG['secret'])
    end
    @graph
  end
end

=begin
  identity = User.first.identities.where(provider: "facebook").first
  @graph = Koala::Facebook::API.new(identity.access_token, FACEBOOK_CONFIG['secret'])
  
  profile = @graph.get_object("me")
  friends = @graph.get_connections("me", "friends")
  email_hash = @graph.get_object("me", :fields => "email")
  
  permissions = @graph.get_connections("me", "permissions")
=end

=begin
  oauth_access_token = 'CAACEdEose0cBAHkpekGt9mbnUVZBayCNZBDF2puI1Qmn109ZCZB07Dst8AGXZCwjYKfaaMfqX8Tm2KmmFs8ySmfyqQCgZCWZBGRP4xyZC4XrXhYhTm2lmYbhWRFCcHpfP9jnXhRZCkiq7NlKDIM9iEOGoZAzIb46zQCz4ZB3TXR6K6lKtidq56sZAaftowTdH2UlxgJjEncACR3d0k4ZCFW1ZBBvZBh'
  @graph = Koala::Facebook::API.new(oauth_access_token)

  profile = @graph.get_object("me")
  friends = @graph.get_connections("me", "friends")
=end