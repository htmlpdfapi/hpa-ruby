require "rest-client"

# Version
require "hpa/version"

# Resources
require "hpa/asset"
require "hpa/credit"
require "hpa/pdf"

# Errors
require "hpa/errors/hpa_error"
require "hpa/errors/api_error"

module Hpa

  @@api_token = nil
  @@api_base = "htmlpdfapi.com/api/v1"

  def self.api_token
    @@api_token
  end

  def self.api_token=(api_token)
    @@api_token = api_token
  end

  def self.api_base
    @@api_base
  end

  def self.api_base=(api_base)
    @@api_base = api_base
  end

  def self.get(resource)
    handle_api_error { RestClient.get(endpoint(resource), authentication) }
  end

  def self.find(resource, id)
    handle_api_error { RestClient.get(endpoint(resource, id), authentication) }
  end

  def self.create(resource, options={})
    handle_api_error { RestClient.post(endpoint(resource), options, authentication) }
  end

  def self.delete(resource, id)
    handle_api_error { RestClient.delete(endpoint(resource, id), authentication) }
  end

  private

    def self.authentication
      {:authentication => ["Token", api_token].join(" ")}
    end

    def self.endpoint(resource, id=nil)
      [api_base, resource, id].compact.join("/")
    end

    def self.handle_api_error
      yield
      rescue RestClient::Exception => e
        raise ApiError.new(e.http_code, e.http_body)
    end

end
