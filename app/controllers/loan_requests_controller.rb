class LoanRequestsController < FrontendController
  skip_before_filter :authenticate_user!, :only => [:create, :update]
  
  def create
      
      
      
      @object = LoanRequest.new
      
      @object.amount = params[:loan_request][:amount]
      @object.loan_purpose =  params[:loan_request][:loan_purpose]
      @object.duration =  params[:loan_request][:duration]
      @object.user_id = current_user.id  
      
      @object.save
       
      redirect_to login_with_facebook_url
      
      
      
  end
  
  def update
    
    @object = LoanRequest.where(:user_id => current_user.id, :id => params[:id]).order("id DESC").first 
    
     
    
    if @object.nil?
      redirect_to root_url 
      return 
    end
    
    @object.amount = params[:loan_request][:amount]
    @object.loan_purpose =  params[:loan_request][:loan_purpose]
    @object.duration =  params[:loan_request][:duration] 
    
    @object.save
     
    redirect_to login_with_facebook_url
    return
    
    
  end
 
end
