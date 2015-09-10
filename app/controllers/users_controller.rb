class UsersController < FrontendController 
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]
  
  
  skip_before_filter :authenticate_user!, :only => [:show]

  def index
    @users = User.all
  end

  # GET /users/:id.:format
  def show
    puts "in the show action of users_controller. The data: #{session[:guest_user_id]}"
    
    if not session[:guest_user_id].nil?
      guest_user = User.find_by_id session[:guest_user_id]
      
      if not guest_user.nil?
        guest_user.move_loan_request_to( current_user ) 
      end
    end
    # authorize! :read, @user
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
 

  # # DELETE /users/:id.:format
  # def destroy
  #   # authorize! :delete, @user
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to root_url }
  #     format.json { head :no_content }
  #   end
  # end
   
   
  def edit_borrower_profile
    @user  = current_user 
  end
  
  def update_borrower_profile
    
    # if not params[:user][:password].present?
    #   current_user.update_password params[:user]
    #   sign_in current_user
    # end
    
    
    if current_user.errors.size !=  0 
      current_user.errors.messages.each {|x| puts "The error msg #{x}" }
    end
    
    
    if params[:user][:user_profile_attributes].present?
      puts "IT IS PRESENT"
      puts "current_user.user_profile.id: #{current_user.user_profile.id}"
      puts "user_profile hash id : #{ params[:user][:user_profile_attributes][:id]}"
    else
      puts "it is not present"
    end
    
    
    if params[:user][:user_profile_attributes].present? and 
        params[:user][:user_profile_attributes][:id].present?
          current_user.user_profile.id == params[:user][:user_profile_attributes][:id].to_i
    
      user_profile  = current_user.user_profile 
      user_profile.update_object( params[:user][:user_profile_attributes])
      
      if user_profile.errors.size != 0 
        user_profile.errors.messages.each {|x| puts "The error msg #{x}" }
      end
    end
    
    redirect_to edit_borrower_profile_url 
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end
