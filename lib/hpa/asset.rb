module Hpa
  class Asset

    def self.get
      Hpa.get(:assets)
    end

    def self.find(id)
      Hpa.find(:assets, id)
    end

    def self.create(options={})
      Hpa.create(:assets, options)
    end

    def self.delete(id)
      Hpa.delete(:assets, id)
    end

  end
end