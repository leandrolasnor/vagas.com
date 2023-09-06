# Desafio para Engenheiro(a) de Software - VAGAS.com

Este documento descreve o passo a passo para rodar a aplicação referente ao desafio da vaga de Engenheiro(a) de Software da VAGAS.com.

## Considerações sobre o ambiente

* Uma image docker foi publicada no [Docker Hub](https://hub.docker.com/layers/leandrolasnor/ruby/vagas.com/images/sha256-cd6cb61240550fb705a38862790902f1a96bcfd2824e357a006682b498fe1d1f?context=explore)

* Use o comando `docker compose up -d` para baixar a imagem e subir o container

```
# docker-compose.yml

services:
  environment:
    image: leandrolasnor/ruby:vagas.com
    container_name: dev.vagas.com
    stdin_open: true
    tty: true
    ports:
      - "3000:3000"
```
* Tudo bem se não quiser usar o Docker 

  * O desafio foi construído usando
    * Ruby 3.2.2
    * Bundler 2.4.19

## Considerações sobre a aplicação

#### Conceitos utilizados na resolução do problema
* Princípio de Inversão de Dependência
* Princípio da Segregação da Interface
* Princípio da responsabilidade única
* Princípio da substituição de Liskov
* Princípio Aberto-Fechado
* Background Processing
* Domain Driven Design
* N+1 query problem
* Código Limpo
* Rubocop
* Dry-rb

## Passo a Passo de como executar a solução

_presumo que nesse momento seu ambiente esteja devidamente configurado_

* Abra três terminais ou três instancias do "terminal integrado" no seu editor
  * No **primeiro** rode:
    * `redis-server`
  * No **segundo** rode:
    * `git pull`
    * `rails db:migrate`
    * `rspec spec` 
    * `rails s` # -------- alternativa: `rails s -b 0.0.0.0 -p 3000`
  * No **terceiro** rode:
    * `rake resque:work QUEUE=dev_default`

* A partir de agora voce tem:
  * Servidor local do redis `Ready to accept connections`
  * Servidor local Puma rodando na porta `3000` e expondo localmente a api atraves do endereço `http://127.0.0.1:3000` ou `http://localhost:3000`
  * Uma unidade de worker do Resque ouvindo a fila `dev_default`
* Agora acesse o [`Swagger`](http://127.0.0.1:3000/api-docs)
  * Você deverá ser capaz de acessar a sua interface web
  * Verifique o campo `defaultHost` na interface do [`Swagger`](http://localhost:3000/api-docs) e avalie se a url esta correta (_127.0.0.1:3000_ ou _localhost:3000_)
    * Nessa interface você poderá validar a documentação dos endpoints e testá-los, enviando algumas requisições http
      1. Crie 3 registros de pessoa na base de dados usando o endpoint `/v1/pessoas`
      2. Crie 1 registro de vaga na base de dados usando o endpoint `/v1/vagas`
      3. Realize a candidatura de todas as pessoas na vaga recém criada usando o endpoint `/v1/candidaturas`
      4. Visualize a lista decrescente de candidaturas ordenadas pelo campo `score` usando o endpoint `/v1/vagas/:job_id/candidaturas/ranking`
