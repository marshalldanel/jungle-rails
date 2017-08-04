class Admin::DashboardController < Admin::AdminController
  
  before_filter :authorize
  
  def show
  end
end
