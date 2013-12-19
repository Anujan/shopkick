class Store::OrdersController < Store::BaseController
  def new
    @customer = Customer.new
  end

  def create
    customer = params[:customer]
    customer[:email_address] = params[:stripeEmail]
    customer[:address_street] = params[:stripeShippingAddressLine1]
    customer[:address_state] = params[:stripeShippingAddressState]
    customer[:address_city] = params[:stripeShippingAddressCity]
    customer[:address_postal_code] = params[:stripeShippingAddressZip]
    customer[:address_country] = params[:stripeShippingAddressCountry]
    names = params[:stripeShippingName].split(" ")
    customer[:first_name] = names.first
    customer[:last_name] = names.last
    @customer = Customer.new(customer)

    stripe_customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    @customer = Customer.find_or_create(customer)

    @customer.stripe_id = stripe_customer.id

    if @customer.save
      @order = Order.from_cart(@cart, @customer)
      if @order.valid?
        @order.save
        @cart.destroy
        OrderWorker.perform_async(current_store, @order, Profile.first.phone_number)
        render :create
      else
        flash[:error] = @order.errors.full_messages
        render :new
      end
    else
      flash[:error] = @customer.errors.full_messages
      render :new
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :new
  rescue Stripe::InvalidRequestError => e
    redirect_to root_url
  end
end