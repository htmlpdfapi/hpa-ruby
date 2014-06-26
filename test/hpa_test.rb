require 'test_helper'

class HpaTest < MiniTest::Unit::TestCase


  def setup 
    # add 2 sec delay between tests
    sleep 2
  end


  def test_get_assets
    response = Hpa::Asset.get
    assert_equal 200, response.code
  end


  def test_create_find_and_delete_asset
    # first, check if asset named "hpa-4ff6375e12f1.png" 
    # already exists and delete it 
    assets = JSON.parse(Hpa::Asset.get.body)
    asset = assets.detect { |a| a["name"] == "hpa-4ff6375e12f1.png"}
    Hpa::Asset.delete(asset["id"]) if asset

    # create asset
    sleep 1
    image = File.open(fixtures_path("hpa-4ff6375e12f1.png"))
    response = Hpa::Asset.create(:file => image)
    assert_equal 201, response.code

    asset = JSON.parse(response.body)

    # find asset
    sleep 1
    response = Hpa::Asset.find(asset["id"])
    assert_equal 200, response.code

    # delete asset
    sleep 1
    response = Hpa::Asset.delete(asset["id"])
    assert_equal 204, response.code
    assert_empty response.body
  end


  def test_get_credits
    response = Hpa::Credit.get

    assert_equal 200, response.code
    assert_match  /\d+/, response.body
  end


  def test_create_pdf_from_string
    response = Hpa::Pdf.create(:html => "<h1>Title</h1>")

    assert_equal 200, response.code
    assert_equal "%PDF", response.body[0, 4]
  end


  def test_create_pdf_from_url
    response = Hpa::Pdf.create(:url => "http://htmlpdfapi.com/examples/example.html")

    assert_equal 200, response.code
    assert_equal "%PDF", response.body[0, 4]
  end


  def test_create_pdf_from_file
    file = File.open(fixtures_path("compressed_file.zip"))
    response = Hpa::Pdf.create(:file => file)

    assert_equal 200, response.code
    assert_equal "%PDF", response.body[0, 4]
  end


end