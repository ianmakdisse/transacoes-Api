Rails.application.routes.draw do
  # Rotas para criar e deletar transações
  resources :transacoes, only: [:create, :destroy]

  # Rota para exibir estatísticas
  get 'estatisticas', to: 'estatisticas#show'
end
