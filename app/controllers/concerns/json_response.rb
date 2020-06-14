module JsonResponse
  def success_response(object, status = :ok, option = {})
    render(
      json: object,
      serializer: option[:serializer],
      each_serializer: option[:each_serializer],
      status: status,
    )
  end

  def error_response(code, status, message)
    json = {
      errors: {
        code: code,
        messages: Array(message),
      },
    }
    render json: json, status: status
  end
end
