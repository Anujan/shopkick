
require 'net/http'
require 'uri'

store = nil
begin
  store = Store.create!(name: 'tv', email: 'tv@shopkick.co', password: 'demo123')
rescue
  store = Store.first
end

URLS = {
  "4K" => "https://www.bestbuy.ca/api/v2/json/sku-collections/33064?categoryid=&currentRegion=ON&include=facets%2C%20redirects&lang=en-CA&page=1&pageSize=24&path=category%3ATV%20%26%20Home%20Theatre%3Bcategory%3ATelevisions&query=&exp=&sortBy=relevance&sortDir=desc",
  "OLED" => "https://www.bestbuy.ca/api/v2/json/sku-collections/12057?categoryid=&currentRegion=ON&include=facets%2C%20redirects&lang=en-CA&page=1&pageSize=24&path=category%3ATV%20%26%20Home%20Theatre%3Bcategory%3ATelevisions&query=&exp=&sortBy=relevance&sortDir=desc",
  "Smart" => "https://www.bestbuy.ca/api/v2/json/sku-collections/17058?categoryid=&currentRegion=ON&include=facets%2C%20redirects&lang=en-CA&page=1&pageSize=24&path=category%3ATV%20%26%20Home%20Theatre%3Bcategory%3ATelevisions&query=&exp=&sortBy=relevance&sortDir=desc"
}

products = []
Apartment::Tenant.switch(store.name) do
  URLS.map do |category, url|
    cat = Category.create!(title: category)
    uri = URI.parse(url)
    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0"
    request["Accept"] = "*/*"
    request["Accept-Language"] = "en-US,en;q=0.5"
    request["Referer"] = "https://www.bestbuy.ca/en-ca/collection/laptops-on-sale/46082?icmp=home_offers_computing_20212901_laptops_on_sale"
    request["Dnt"] = "1"
    request["Connection"] = "keep-alive"
    request["Te"] = "Trailers"

    req_options = {
      use_ssl: uri.scheme == "https",
      :verify_mode => OpenSSL::SSL::VERIFY_NONE
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    res = JSON.parse(response.body)
    res["products"].each do |product|
      item = {}
      item[:title] = product["name"]
      item[:price] = product["salePrice"] || product["regularPrice"]
      item[:old_price] = product["regularPrice"]
      item[:description] =  product["shortDescription"]
      image = product["highResImage"].gsub("https:", "http:")
      next if image.blank? || image.include?("/noimage")
      item[:images_attributes] = Array.new()
      item[:images_attributes] << { :photo => URI.parse(image) }
      item[:sku] = product["sku"]
      item[:category_id] = cat.id
      products << Product.create!(item) unless item.values.any?(&:blank?)
    end
  end

  Customer.create(first_name: 'Anujan', last_name: 'Panchadcharam',
    address_street: '770 Broadway', address_city: 'New York', address_state: 'New York',
    address_country: 'USA', address_postal_code: '10003', email_address: 'Anujan714@gmail.com',
    phone_number: "+19173328921")

  dates = [10.days.ago..Date.today]

  r = Random.new

  30.times do |i|
    attrs = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      address_street: Faker::Address.street_address,
      address_city: Faker::Address.city,
      address_state: Faker::Address.state,
      address_country: 'USA',
      address_postal_code: Faker::Address.postcode,
      phone_number: Faker::PhoneNumber.cell_phone
    }
    attrs[:email_address] = Faker::Internet.email("#{attrs[:first_name]} #{attrs[:last_name]}")

    cust = Customer.create!(attrs)

    order = Order.new
    order.customer = cust
    order_products = products.sample(r.rand(2..5))
    order.product_ids = order_products.map(&:id)
    order.price = order_products.map(&:price).inject(&:+)
    order.fulfillment_status = Order::FULFILLMENT_STATUSES.sample
    order.payment_status = Order::PAYMENT_STATUSES.sample
    order.save
  end
end
puts 'Done seeding!'