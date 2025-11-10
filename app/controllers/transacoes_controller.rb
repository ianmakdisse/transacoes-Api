class TransacoesController < ApplicationController
  def create
    transacao = TransacaoService.create!(transacao_params)
    TransacaoStore.add(transacao)
    EstatisticasService.invalidate_cache!
    head :created
  rescue TransacaoService::InvalidParamsError => e
    render json: { error: e.message }, status: :bad_request
  rescue TransacaoService::UnprocessableError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy
    TransacaoStore.clear
    EstatisticasService.invalidate_cache!
    head :ok
  end

  private

  def transacao_params
    params.require(:transacao).permit(:valor, :dataHora)
  end
end
