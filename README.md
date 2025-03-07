# README

Sejam bem-vindos ao URL SHORTENER. Um pequeno sistema que recebe uma URL, encurta seu tamanho, conta e armazena os acessos a URL encurtada
e também mostra um histórico de acessos dessa URL encurtada.

Para realizar a "mágica", antes você deve clonar o repositório e uma vez na sua máquina:

* Executar `docker compose build`

* Seguido de `docker compose up`

* Certifique-se de rodar as migrations após a inicialização através do comando: `docker compose run web rails db:migrate`

* Com o ambiente localhost rodando, você pode encurtar uma url através do comando `curl -X POST -H "Content-Type: application/json" -d '{"url": {"original_url": "http://example.com"}}' http://localhost:3000/urls`

* Que te dará uma resposta em JSON com uma URL encurtada contendo um valor aleatório, entre 5 a 10 caracteres, como por exemplo: `{"short_url":"http://localhost:3000/2btHq"}`

* Se você quiser acessar a URL original através da encurtada que foi gerada é muito fácil, basta digitar: `curl -v http://localhost:3000/2btHq`. Na resposta, é só observar o campo `< location: http://example.com`

* E por último os "stats" da URL encurtada. Para você saber quantas vezes ela foi acessada e um log com as datas de acesso, basta fazer: `curl  http://localhost:3000/2btHq/stats`

* Você também pode agregar uma data de expiração à URL encurtada, seguindo assim: `curl -X POST -H "Content-Type: application/json" -d '{"url": {"original_url": "http://example.com", "expires_at":"2025-03-20"}}' http://localhost:3000/urls`

* Espero que tenham gostado!
