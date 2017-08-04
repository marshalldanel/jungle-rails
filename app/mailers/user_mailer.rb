class UserMailer < ApplicationMailer
  default from: 'no-reply@'+ ENV['domain']

  def order_confirmation(order)
    @order = order
    mail to: @order.email, subject: "Here's the Jungle recipt for Order #{ @order.id }!"
  end

end
