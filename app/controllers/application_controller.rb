class ApplicationController < ActionController::API
  # Trata JSON mal formatado → Retorna 400
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :render_bad_request

  # Trata falta de parâmetros obrigatórios → Retorna 422
  rescue_from ActionController::ParameterMissing, with: :render_unprocessable_entity

  private

  def render_bad_request
    render status: :bad_request, json: {}
  end

  def render_unprocessable_entity
    render status: :unprocessable_entity, json: {}
  end
end
