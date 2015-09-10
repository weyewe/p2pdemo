class WelcomeController < FrontendController
  layout 'home'
  
  skip_before_filter :authenticate_user!, :only => [:index, :login_with_facebook]
  
  def index
      if current_user.loan_requests.count == 0
        @loan_request = LoanRequest.new 
      else
        @loan_request = current_user.loan_requests.order("id DESC").last 
      end
     
  end
  
  def login_with_facebook
    if not current_user
      redirect_to root_url
      return 
    elsif current_user and current_user.is_guest?
      if current_user.loan_requests.count == 0 
        redirect_to root_url
        return 
      end
    end
    
    @loan_request = current_user.loan_requests.first 
    
 
  end
end
