class OrderWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :order

  def perform(store_email, order_id, store_phone_number=nil)
    order = Order.find(order_id)
    order.charge!

    client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_AUTH_TOKEN'])

    twilio_number = ENV["TWILIO_PHONE_NUMBER"]

    cust_phone = order.customer.phone_number

    unless cust_phone.blank?
      client.account.messages.create(
        :from => twilio_number,
        :to => cust_phone,
        :body => "Hey there! We recieved your payment for Order ##{order_id} of #{order.price}!"
      )
    end

    unless store_phone_number.blank?
      client.account.messages.create(
        :from => twilio_number,
        :to => store_phone_number,
        :body => "Hey there! You recieved a payment for Order ##{order_id} of #{order.price}!"
      )
    end

    OrderMailer.payment_recieved(store_email, order).deliver
    OrderMailer.order_confirmation(order).deliver
  end
end