Apartment.configure do |config|
  config.default_schema = 'public'
  config.tenant_names = lambda{ Store.pluck(:name) }
  config.excluded_models = ["Store", "Session"]
end