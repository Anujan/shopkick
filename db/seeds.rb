require 'nokogiri'
require 'open-uri'

store = Store.create!(name: 'bookstore', email: 'example@shopkick.co', password: 'demo123')
category = Category.create(title: "Newest Releases")

URL = 'http://www.amazon.com/s/ref=lp_283155_nr_p_n_publication_date_0?rh=n%3A283155%2Cp_n_publication_date%3A1250226011&bbn=283155&ie=UTF8&qid=1386952388&rnid=1250225011'
page = Nokogiri::HTML(open(URL))
page.css(".product").each do |product|
  p = product.css('.productTitle > a')
  book = {}
  book[:title] = p.inner_text.strip
  img = product.css('.productImage > a > img')
  book[:images_attributes] = Array.new()
  book[:images_attributes] << { :photo => URI.parse(img.attr('src').value) }
  price = product.css('.newPrice > span').inner_text.gsub("$", "")
  book[:price] = price
  book[:category] = category
  book[:description] = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  Product.create!(book)
end

