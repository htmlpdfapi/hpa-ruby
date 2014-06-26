require 'hpa'
require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'


class MiniTest::Unit::TestCase

  Hpa.api_token = ENV['api_token']
  Hpa.api_base = ENV['api_base'] if ENV['api_base']

  def fixtures_path(filename)
    File.join(File.dirname(__FILE__), "fixtures", filename)
  end
  
end