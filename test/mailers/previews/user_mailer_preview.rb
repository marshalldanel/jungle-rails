class UserMailerPreview < ActionMailer::Preview
  
  def order_confirmation
    UserMailer.order_confirmation(Order.first)
  end
end