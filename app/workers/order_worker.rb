class SidekiqWorker
  include Sidekiq::Worker

  def perform(store_email, order_id)
    order = Order.find(order_id)
    order.charge!
    OrderMailer.delay.payment_recieved(store_email, order)
    OrderMailer.delay.order_confirmation(order)
  end
end