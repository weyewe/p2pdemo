class User < ActiveRecord::Base
  
  has_many :loan_requests 
  
  has_one :user_profile 
  accepts_nested_attributes_for :user_profile, reject_if: :all_blank, allow_destroy: false
  
  has_many :work_experiences
  accepts_nested_attributes_for :work_experiences, reject_if: :all_blank, allow_destroy: true

  
  
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  has_many :identities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,  #, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)
    
    # puts "Inside the find_for_oauth "
    # puts "#{auth.inspect}"
    puts "The info:"
    puts "#{auth.info.inspect}"
    
    puts "yadayadayada"
    puts "#{auth.info.email} , #{auth.info.first_name}, #{auth.info.last_name}, #{auth.info.image}, #{auth.info.urls.Facebook}"
    
    
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user
    
    
    

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      # email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      # email = auth.info.email if email_is_verified
      email = auth.info.email # if email_is_verified
      user = User.where(:email => email).first if email

      
      
      # Create the user if it's a new registration
      if user.nil?
        
  
      
      
        user = User.new(
          #username: auth.info.nickname || auth.uid,
          email: email, # ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        # user.skip_confirmation!
        user.save!
        
        UserProfile.populate_from_facebook( auth.info, user )
         
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
  
  def update_password( params )  
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]
    self.save 
    
    return save 
  end
  
  def save_email_password( params )
    self.email = params[:email]
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]
    self.save
    
    
    return self 
  end
  
  
  def move_loan_request_to( target_user ) 
    self.loan_requests.each do |x|
      x.user_id  = target_user.id  
      x.save 
    end
  end
  
 
end
