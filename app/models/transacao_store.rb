class TransacaoStore
  @transacoes = []
  @mutex = Mutex.new

  class << self
    def add(transacao)
      @mutex.synchronize { @transacoes << transacao }
    end

    def all
      @mutex.synchronize { @transacoes.dup }
    end

    def clear
      @mutex.synchronize { @transacoes.clear }
    end
  end
end
