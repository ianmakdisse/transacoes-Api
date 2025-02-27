class TransacoesController < ApplicationController
  def create
    valor = transacao_params[:valor].to_f
    data_hora = DateTime.iso8601(transacao_params[:dataHora]) rescue nil


    unless TransacaoService.validate(valor, data_hora)
      return render_unprocessable_entity
    end

    TRANSACTIONS << { valor: valor, dataHora: data_hora }
    puts "=== TRANSACTIONS APÓS ADICIONAR ==="
    p TRANSACTIONS # Exibe no log

    render status: :created, json: {}
  end


  def destroy
    TRANSACTIONS.clear
    render status: :ok, json: {}
  end

  private

  def transacao_params
    params.require(:transacao).permit(:valor, :dataHora)
  end
end
