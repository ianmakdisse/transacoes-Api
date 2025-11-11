#  API de Transações e Estatísticas em Tempo Real

Uma API desenvolvida em **Ruby on Rails** que registra transações financeiras e calcula **estatísticas dinâmicas** dos últimos 8 minutos.  
O projeto simula um serviço em tempo real de análise de dados, com foco em boas práticas de design de API e arquitetura limpa.

---

##  Visão Geral

A aplicação permite:

- Criar novas transações com valor e data/hora;  
- Consultar estatísticas atualizadas (soma, média, mínimo, máximo, quantidade);  
- Limpar todas as transações registradas.  

As transações são armazenadas **em memória**, sem banco de dados — ideal para demonstrar lógica de processamento e filtragem.

---

##  Tecnologias
# API de Transações e Estatísticas em Tempo Real

Uma API desenvolvida em **Ruby on Rails** que registra transações financeiras e calcula **estatísticas dinâmicas** dos últimos 8 minutos.
O projeto simula um serviço em tempo real de análise de dados, com foco em boas práticas de design de API e arquitetura limpa.

---

## Visão Geral

A aplicação permite:

- Criar novas transações com valor e data/hora;
- Consultar estatísticas atualizadas (soma, média, mínimo, máximo, quantidade);
- Limpar todas as transações registradas.

As transações são armazenadas **em memória**, sem banco de dados — ideal para demonstrar lógica de processamento e filtragem.

---

## Tecnologias

- **Ruby 3.x**
- **Rails 7.x**
- **Serviço de validação isolado (`TransacaoService`)**
- **Memória temporária com Array global (`TRANSACOES`)**

---

## Estrutura de Pastas (resumo)

```
app/
 ├── controllers/
 │    ├── transacoes_controller.rb
 │    └── estatisticas_controller.rb
 ├── services/
 │    └── transacao_service.rb
config/
 └── routes.rb
```

---

## Rodando com Docker Compose

Este repositório já inclui um `docker-compose.yml` com um serviço chamado `api` que expõe a porta 3000 (mapeamento `3000:3000`). Use os passos abaixo para rodar a aplicação dentro de containers.

Pré-requisitos:

- Docker e Docker Compose instalados (ou Docker Desktop no Windows / WSL2).

Passos rápidos:

1. Build e start (modo interativo):

```bash
docker-compose up --build
```

2. Rodar em background (detached):

```bash
docker-compose up --build -d
```

3. Ver logs do serviço `api`:

```bash
docker-compose logs -f api
```

4. Entrar no container para rodar comandos Rails (ex.: console, rake, testes):

```bash
docker-compose exec api bash
# dentro do container você pode executar: rails c, rails db:migrate (se necessário), rake, rspec
```

Observações no compose atual:

- Serviço: `api` (container_name: `transacoes_api`)
- Porta exposta: `3000` → acesse em http://localhost:3000
- Volume: o diretório do projeto é montado em `/app` (mudanças no host refletem no container)
- Variáveis de ambiente: `RAILS_ENV=development`

Como a aplicação armazena transações em memória, não é obrigatório rodar migrations. Caso adicione banco (Postgres/SQLite) mais tarde, execute o fluxo normal de migrations dentro do container.

---

## Comandos úteis

- Subir e reconstruir: `docker-compose up --build`
- Subir em background: `docker-compose up -d --build`
- Parar: `docker-compose down`
- Parar e remover volumes: `docker-compose down -v`
- Executar comando dentro do container: `docker-compose exec api <comando>`
- Remover imagens criadas manualmente (quando necessário): `docker-compose down --rmi all`

---

## Acesso à API

Endpoints principais:

- POST /transacoes — cria nova transação
- DELETE /transacoes — remove todas as transações
- GET /estatisticas — retorna estatísticas das transações dos últimos 8 minutos

Exemplo de requisição para criar uma transação (curl):

```bash
curl -X POST http://localhost:3000/transacoes \
  -H "Content-Type: application/json" \
  -d '{"transacao": {"valor": 42.50, "dataHora": "2025-10-16T22:30:00.000Z"}}'
```

Exemplo de consulta de estatísticas:

```bash
curl -X GET http://localhost:3000/estatisticas
```

---

## Troubleshooting rápido

- Se a aplicação não subir, verifique os logs: `docker-compose logs api`.
- Em WSL/Windows, se houver problemas com permissões de arquivos montados, tente usar WSL2 com Docker integrado ou ajustar as permissões na máquina host.
- Se a porta 3000 já estiver em uso, altere o mapeamento no `docker-compose.yml` (ex.: `3001:3000`) e acesse `http://localhost:3001`.

---

## Desenvolvimento local (opcional)

Se preferir rodar sem Docker:

```bash
bundle install
rails s
```

---

## Funcionamento Interno (resumo)

- `POST /transacoes` → `TransacoesController#create` → validação em `TransacaoService` → adiciona à lista `TRANSACOES`
- `GET /estatisticas` → `EstatisticasController#show` → filtra últimas 8 minutos → calcula soma, média, mínimo, máximo e quantidade → retorna JSON

---

## Próximos Passos

- Adicionar testes automatizados (RSpec)
- Migrar armazenamento para Redis ou PostgreSQL
- Criar frontend simples para visualização
- Adicionar jobs para expiração automática de transações

> Desenvolvido com Ruby on Rails — para fins de aprendizado e demonstração de boas práticas de API.
