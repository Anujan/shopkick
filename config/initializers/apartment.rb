Apartment.configure do |config|
  config.default_schema = 'public'
  config.excluded_models = ["Store", "Session"]
end