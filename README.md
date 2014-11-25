hpa-ruby
=====

This is a Ruby wrapper for [HTML PDF API](https://htmlpdfapi.com) - [Documentation](https://htmlpdfapi.com/documentation)

HTML PDF API is a service that allows you to convert HTML to PDF using standard technologies (HTML, CSS and JavaScript).


Installation
=====

### Rails

Add this line to your application"s Gemfile:

    gem "hpa-ruby", require: "hpa"

And then execute:

    $ bundle


### Or install it yourself

    $ gem install hpa-ruby


Usage
=====

Require the Hpa gem

    require "hpa"

Then you have to set your API token:

    Hpa.api_token = "<your token>"

## Configuration

Set API base (endpoint and version)

    Hpa.api_base = "https://htmlpdfapi.com/api/v1" # default


Assets
-------

### Get Assets List
    
    response = Hpa::Asset.get
    assets = JSON.parse(response) 

on success returns: 

    response # json object
    response.code # 200

    JSON.parse(response) # [{"id":"53a99cc76d64be7c26b5e57b", "name":"hpa_logo.png", "mime":"image/png", "size":650}, {...}, {...}]


### Create Asset

    response = Hpa::Asset.create(:file => File.open("path/to/file.png"))

on success returns: 

    response # json object
    response.code # 201

    JSON.parse(response) # {"id":"53a99cc76d64be7c26b5e57b", "name":"hpa_logo.png", "mime":"image/png", "size":650}


### Find Asset

    response = Hpa::Asset.find(id)

on success returns: 

    response # file
    response.code # 200


### Delete Asset

    response = Hpa::Asset.delete(id)

on success returns: 

    response # ""
    response.code # 204


Credits
-------

    response = Hpa::Credit.get

on success returns: 

    response # current number of credits
    response.code # 200


PDFs
-------

### Generate PDF

From url:

    response = Hpa::Pdf.create(:url => "https://htmlpdfapi.com/examples/example.html")

From HTML string:

    response = Hpa::Pdf.create(:html => "<h1>Generate PDF from HTML string</h1>")

From HTML file:

    response = Hpa::Pdf.create(:file => File.open("index.html"))

From compressed file:

    response = Hpa::Pdf.create(:file => File.open("sample.zip"))

on success returns: 

    response # file (PDF)
    response.code # 200

save it to a file

    File.open("result.pdf", "w+") do |f|
      f.write response
    end


Notice:

    response == response.body
    

### Passing additional options 

    Hpa::Pdf.create(
      :file => File.open("index.html"),
      :dpi => 150,
      :margin_top => 20mm
    )

[Full options list](https://htmlpdfapi.com/documentation#pdf)

Rails example
=====

Set your api token inside config/application.rb

    module HpaExample
      class Application < Rails::Application

        Hpa.api_token = "<your token>"

      end
    end



controllers/example_controller.rb

    class ExampleController < ApplicationController

      def show
        respond_to do |format|
          format.html { render(layout: "pdf") }

          format.pdf do
            pdf = Hpa::Pdf.create( 
              html: render_to_string(layout: "pdf").to_str,
              header: render_to_string(template: "example/header.erb", layout: "pdf").to_str,
              footer: render_to_string(template: "example/footer.erb", layout: "pdf").to_str,
              header_spacing: 10,
              footer_spacing: 10,
              engine_version: 12
            )

            send_data(pdf, filename: "hpa_rails_example.pdf", type: "application/pdf", disposition: "inline")
          end

        end
      end

    end


[Sample Rails application](https://github.com/htmlpdfapi/hpa_rails_example)


Testing
-------
    rake test api_token="<your token>"

## Contributing

1. Fork it ( https://github.com/htmlpdfapi/hpa-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request