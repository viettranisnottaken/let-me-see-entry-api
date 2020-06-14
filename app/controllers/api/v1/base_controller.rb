module Api::V1
  class BaseController < ApplicationController
    include JsonResponse

    skip_before_action :verify_authenticity_token

    rescue_from StandardError, with: :internal_server_error_response
    rescue_from ActiveRecord::RecordNotFound, with: :notfound_response_handler
    rescue_from ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, with: :unprocessable_entity_response
    rescue_from ActionController::ParameterMissing, with: :parameter_missing_response

    private

    def notify(exception)
      return unless exception

      logger.error exception.message
      logger.error exception.backtrace.join("\n")
    end

    def internal_server_error_response(exception = nil)
      notify(exception)
      error_response(
        500,
        :internal_server_error,
        I18n.t("api.v1.error_messages.standard_error_msg"),
      )
    end

    def notfound_response_handler(exception)
      notify(exception)
      error_response(
        404,
        :not_found,
        exception.message,
      )
    end

    def parameter_missing_response(exception = nil)
      notify(exception)
      error_response(
        400,
        :bad_request,
        I18n.t("api.v1.error_messages.bad_request_msg"),
      )
    end

    def unprocessable_entity_response(exception)
      notify(exception)
      error_response(
        422,
        :unprocessable_entity,
        exception.record.errors.full_messages,
      )
    end

  end
end
