# frozen_string_literal: true

module HuaweiPushKit
  class ApiResponse
    def initialize(response)
      @response = JSON.parse(response.body)
    end

    def successful?
      response["code"] == "80000000"
    end

    def error
      response["errors"]&.join(", ")
    end

    def body
      response
    end

    private

    attr_reader :response
  end
end
