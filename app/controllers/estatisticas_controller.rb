class EstatisticasController < ApplicationController
  def show
    estatisticas = EstatisticasService.calcular
    render json: estatisticas
  end
end
