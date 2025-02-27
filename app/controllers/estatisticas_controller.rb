class EstatisticasController < ApplicationController

  def show
    puts "=== TRANSACTIONS NO SHOW ==="
    p TRANSACTIONS # Exibe no log

    transactions = TRANSACTIONS.select do |t|
      t[:dataHora].to_time  > 8.minute.ago
    end

    values = transactions.map { |t| t[:valor].to_f }

    stats = {
      count: values.size,
      sum: values.sum.round(2),
      avg: values.empty? ? 0 : (values.sum / values.size).round(2),
      min: values.min || 0,
      max: values.max || 0
    }

    render json: stats
  end

end
