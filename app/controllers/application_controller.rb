# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = Error.new
    error.add(:parameter_missing_exception, scope: %i[errors messages], parameter: parameter_missing_exception.param)
    render json: ErrorSerializer.serialize(error), status: :bad_request
  end

  protected

  def handle_error_response(response:, status_code:)
    error = Error.new.add_all_messages(response.active_record_errors)
    error_response = ErrorSerializer.serialize(error)
    handle_response(response: error_response, status_code: status_code)
  end

  def handle_response(response:, status_code:)
    render json: response, status: status_code
  end
end
