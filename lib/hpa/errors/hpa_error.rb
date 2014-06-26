module Hpa
  class HpaError < StandardError

    attr_reader :status, :message

    def initialize(status=nil, message=nil)
      @status = status
      @message = message
    end

    def to_s
      [status, message].compact.join(" ")
    end

  end
end