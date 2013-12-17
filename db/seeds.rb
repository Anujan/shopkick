require 'mechanize'

store = Store.create!(name: 'DigitalDream', email: 'digital@shopkick.co', password: 'demo123')

URLS = {
  "LCD" => "http://www.bestbuy.com/site/olstemplatemapper.jsp?_dyncharset=ISO-8859-1&_dynSessConf=4038258141416413124&id=pcat17071&type=page&ks=960&st=pcmcat193400050017_categoryid%24abcat0101001&sc=Global&cp=1&sp=-bestsellingsort+skuidsaas&qp=tvtype_facet%3DSAAS~TV+Type~LCD+Flat-Panel&list=n&usc=All+Categories&nrp=25&fs=saas&iht=n&seeAll=&browsedCategory=pcmcat193400050017",
  "LED" => "http://www.bestbuy.com/site/olstemplatemapper.jsp?_dyncharset=ISO-8859-1&_dynSessConf=4038258141416413124&id=pcat17071&type=page&ks=960&st=pcmcat193400050018_categoryid%24abcat0101001&sc=Global&cp=1&sp=-bestsellingsort+skuidsaas&qp=tvtype_facet%3DSAAS~TV+Type~LED+Flat-Panel&list=n&usc=All+Categories&nrp=25&fs=saas&iht=n&seeAll=&browsedCategory=pcmcat193400050018",
  "Plasma" => "http://www.bestbuy.com/site/olstemplatemapper.jsp?_dyncharset=ISO-8859-1&_dynSessConf=4038258141416413124&id=pcat17071&type=page&ks=960&st=pcmcat193400050016_categoryid%24abcat0101001&sc=Global&cp=1&sp=-bestsellingsort+skuidsaas&qp=tvtype_facet%3DSAAS~TV+Type~Plasma+Flat-Panel&list=n&usc=All+Categories&nrp=25&fs=saas&iht=n&seeAll=&browsedCategory=pcmcat193400050016",
  "OLED" => "http://www.bestbuy.com/site/televisions/oled-tvs/pcmcat301000050010.c?id=pcmcat301000050010",
  "3D" => "http://www.bestbuy.com/site/televisions/3d-tvs/pcmcat205800050000.c?id=pcmcat205800050000",
  "SmartTV" => "http://www.bestbuy.com/site/televisions/smart-tvs/pcmcat220700050011.c?id=pcmcat220700050011"
}

results = {}

agent = Mechanize.new

URLS.map do |category, url|
  category = Category.create!(title: category)
  page = agent.get(url)
  results[category] = []
  page.search(".hproduct").each do |product|
    p = product.search('a[rel=product]')
    item = {}
    item[:title] = p.inner_text.strip
    price = product.search('.info-side > div > .price > span').inner_text.gsub("$", "")
    item[:price] = price
    old_price = product.search('.info-side > div > .regular > span').inner_text.gsub("$", "")
    unless old_price == price
      item[:old_price] = old_price
    end
    inner_page = page.link_with(href: p.attr('href').value).click
    item[:description] = inner_page.search("#long-description").text.strip
    image = inner_page.search('.image-gallery-main-slide img')
    item[:image] = image.attr('src').value
    item[:sku] = inner_page.search('#sku-value').text
    item[:category_id] = category.id
    Product.create!(item) unless item.values.any?(&:empty?)
  end
end