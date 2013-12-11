module Apartment
  module Elevators
    class Subdomain
      def self.excluded_subdomains
        @@excluded_subdomains ||= []
      end

      def self.excluded_subdomains=(arg)
        @@excluded_subdomains = arg
      end

      def parse_database_name(request)
        request_subdomain = subdomain(request.host)
        database = if self.class.excluded_subdomains.include?(request_subdomain)
          nil
        else
          request_subdomain
        end

        database.present? && database || nil
      end
    end
  end
end
Apartment::Elevators::Subdomain.excluded_subdomains = ['www']