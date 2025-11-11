class EstatisticasService
  WINDOW_MINUTES = 8
  @cache = nil
  @last_updated_at = nil
  @mutex = Mutex.new

  class << self
    def calcular
      return @cache if cache_valido?

      @mutex.synchronize do
        return @cache if cache_valido?

        transacoes_recentes = TransacaoStore.all.select do |t|
          t[:dataHora].to_time > WINDOW_MINUTES.minutes.ago
        end

        valores = transacoes_recentes.map { |t| t[:valor].to_f }

        @cache = {
          count: valores.size,
          sum: valores.sum.round(2),
          avg: valores.any? ? (valores.sum / valores.size).round(2) : 0,
          min: valores.min || 0,
          max: valores.max || 0,
          updated_at: Time.now
        }

        @last_updated_at = Time.now
        @cache
      end
    end

    def invalidate_cache!
      @mutex.synchronize do
        @cache = nil
        @last_updated_at = nil
      end
    end

    private

    def cache_valido?
      @cache && @last_updated_at && (Time.now - @last_updated_at < 1)
    end
  end
end
