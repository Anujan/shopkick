require 'mechanize'

store = Store.create!(name: 'tv', email: 'tv@shopkick.co', password: 'demo123')

URLS = {
  "LCD" => "http://www.bestbuy.com/site/olstemplatemapper.jsp?_dyncharset=ISO-8859-1&_dynSessConf=4038258141416413124&id=pcat17071&type=page&ks=960&st=pcmcat193400050017_categoryid%24abcat0101001&sc=Global&cp=1&sp=-bestsellingsort+skuidsaas&qp=tvtype_facet%3DSAAS~TV+Type~LCD+Flat-Panel&list=n&usc=All+Categories&nrp=25&fs=saas&iht=n&seeAll=&browsedCategory=pcmcat193400050017",
  "LED" => "http://www.bestbuy.com/site/olstemplatemapper.jsp?_dyncharset=ISO-8859-1&_dynSessConf=4038258141416413124&id=pcat17071&type=page&ks=960&st=pcmcat193400050018_categoryid%24abcat0101001&sc=Global&cp=1&sp=-bestsellingsort+skuidsaas&qp=tvtype_facet%3DSAAS~TV+Type~LED+Flat-Panel&list=n&usc=All+Categories&nrp=25&fs=saas&iht=n&seeAll=&browsedCategory=pcmcat193400050018",
  "Plasma" => "http://www.bestbuy.com/site/olstemplatemapper.jsp?_dyncharset=ISO-8859-1&_dynSessConf=4038258141416413124&id=pcat17071&type=page&ks=960&st=pcmcat193400050016_categoryid%24abcat0101001&sc=Global&cp=1&sp=-bestsellingsort+skuidsaas&qp=tvtype_facet%3DSAAS~TV+Type~Plasma+Flat-Panel&list=n&usc=All+Categories&nrp=25&fs=saas&iht=n&seeAll=&browsedCategory=pcmcat193400050016",
  "OLED" => "http://www.bestbuy.com/site/televisions/oled-tvs/pcmcat301000050010.c?id=pcmcat301000050010",
  "3D" => "http://www.bestbuy.com/site/televisions/3d-tvs/pcmcat205800050000.c?id=pcmcat205800050000",
  "SmartTV" => "http://www.bestbuy.com/site/televisions/smart-tvs/pcmcat220700050011.c?id=pcmcat220700050011"
}

products = []

agent = Mechanize.new

URLS.map do |category, url|
  cat = Category.create!(title: category)
  page = agent.get(url)
  page.search(".hproduct").each do |product|
    p = product.search('a[rel=product]')
    item = {}
    item[:title] = p.inner_text.strip
    item[:title] = item[:title][25..-1] if item[:title].start_with?("Available from")
    price = product.search('.info-side > div > .price > span').inner_text.gsub("$", "").gsub(",", "")
    item[:price] = price
    old_price = product.search('.info-side > div > .regular > span').inner_text.gsub("$", "").gsub(",", "")
    unless old_price == price || old_price.to_s.empty?
      item[:old_price] = old_price
    end
    inner_page = page.link_with(href: p.attr('href').value).click
    item[:description] = inner_page.search("#long-description").text.strip
    image = inner_page.search('.image-gallery-main-slide img')
    if image.empty?
      image = inner_page.search("#imagepreview img")
    end
    next if image.empty?
    item[:images_attributes] = Array.new()
    item[:images_attributes] << { :photo => URI.parse(image.attr('src').value) }
    item[:sku] = inner_page.search('#sku-value').text unless inner_page.search("#sku-value").empty?
    item[:category_id] = cat.id
    products << Product.create!(item) unless item.values.any?(&:blank?)
  end
end

Customer.create(first_name: 'Anujan', last_name: 'Panchadcharam',
  address_street: '770 Broadway', address_city: 'New York', address_state: 'New York',
  address_country: 'USA', address_postal_code: '10003', email_address: 'Anujan714@gmail.com',
  phone_number: "+19173328921")

dates = [(Date.today - 10)..Date.today]

r = Random.new

30.times do |i|
  attrs = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address_street: Faker::Address.street_address,
    address_city: Faker::Address.city,
    address_state: Faker::Address.state,
    address_country: Faker::Address.country,
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
puts 'Done seeding!'