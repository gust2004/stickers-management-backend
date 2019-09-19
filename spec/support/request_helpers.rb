# frozen_string_literal: true

module Requests
  module JsonHelpers
    def parsed_response
      parsed_body(response.body)
    end

    def parsed_body(body)
      @parsed_body ||= JSON.parse(body, symbolize_names: true)
    end
  end
end
