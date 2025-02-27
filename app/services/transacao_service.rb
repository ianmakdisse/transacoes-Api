class TransacaoService
  def self.validate(valor, data_hora)
    return false if valor.negative? || data_hora > DateTime.current
    true
  end
end
