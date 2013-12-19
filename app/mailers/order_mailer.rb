class OrderMailer < ActionMailer::Base
  default :from => 'no-reply@shopkick.co'

  def order_confirmation(order)
    @order = order
    mail( to: @order.customer.email_address,
      subject: "Confirmation for Order ##{order.id}" )
  end

  def payment_recieved(store_email, order)
    @order = order

    mail( to: store_email,
      subjust: "Payment recieved from #{order.customer.full_name} for Order ##{order.id}" )
  end
end