class TransacaoService
  class InvalidParamsError < StandardError; end
  class UnprocessableError < StandardError; end

  def self.create!(params)
    valor = Float(params[:valor]) rescue nil
    data_hora = DateTime.iso8601(params[:dataHora]) rescue nil

    raise InvalidParamsError.new("Parâmetros inválidos: valor e dataHora são obrigatórios") if valor.nil? || data_hora.nil?

    raise UnprocessableError.new("Valor não pode ser negativo") if valor.negative?
    raise UnprocessableError.new("Data/hora não pode ser no futuro") if data_hora > DateTime.now

    { valor: valor, dataHora: data_hora }
  end
end
