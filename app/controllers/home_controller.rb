class HomeController < ApplicationController
  layout 'sidenav'
  
  def borrower_application
    @borrower_profile = BorrowerProfile.new 
  end
  
  
end
