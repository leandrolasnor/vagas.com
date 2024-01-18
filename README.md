# Desafio para Engenheiro(a) de Software - VAGAS.com

:page_with_curl: [Enunciado do problema](https://github.com/VAGAS-com/teste-tecnico-backend/blob/main/desafio-tecnico.md)

#### Conceitos e ferramentas utilizadas na resolução do problema
`Docker`

`Rails` `Dry-rb` `RSpec` `RSwag`

`SOLID` `DDD` `Clear Code` `Clean Arch`

# .devcontainer :whale:

1. Rode o comando no Visual Studio Code `> Dev Containers: Clone Repository in Container Volume...` e dê `Enter`.
2. Informe a url: `https://github.com/leandrolasnor/vagas.com` e dê `Enter`
4. :hourglass_flowing_sand: Aguarde até [+] Building **352.7s** (31/31) FINISHED

## Com o processo de build concluido, faça:

* Rode o comando no terminal: `bundle exec rails s -b '0.0.0.0'`

## Documentação

* Acesse o [`Swagger`](http://localhost:3000/api-docs)
* Verifique o campo `defaultHost` na interface do [`Swagger`](http://localhost:3000/api-docs) e avalie se a url esta correta (_127.0.0.1:3000_ ou _localhost:3000_)

* Nessa interface você poderá validar a documentação dos endpoints e testá-los, enviando algumas requisições http
  1. Crie 3 registros de pessoa na base de dados usando o endpoint `/v1/pessoas`
  2. Crie 1 registro de vaga na base de dados usando o endpoint `/v1/vagas`
  3. Realize a candidatura de todas as pessoas na vaga recém criada usando o endpoint `/v1/candidaturas`
  4. Visualize a lista decrescente de candidaturas ordenadas pelo campo `score` usando o endpoint `/v1/vagas/:job_id/candidaturas/ranking`
