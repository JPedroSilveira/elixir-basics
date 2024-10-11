# Sorteio API

## Dependências
- Instale a linguagem Elixir: https://elixir-lang.org/install.html (Versão 1.17.3)
    - Verifique a instalação com o comando `elixir -v`
- Instale o framework Phoenix através do comando: `mix archive.install hex phx_new`
- Instale Docker, Nerdctl, ou qualquer outro gerenciador de containers

## Criação do banco de dados local
- Caso tenha optado pelo uso do Nerdctl basta executar o arquivo `start-locally.sh`, ou executar os seguintes comandos:
    - `nerdctl [ou docker] build --file ./Dockerfile.database -t database .` => Build da imagem com o banco de dados
    - `nerdctl [ou docker] run -d --name database-container -p 81:5432 database`, => Inicialização do container utilizando a porta 81 (certifique-se de que ela não esteja sendo utilizada por nenhuma outra aplicação)
    - Caso a porta 81 não esteja disponível modifique para uma válida o comando e em seguite atualize os arquivos [config/dev.exs](config/dev.exs) e [config/test.exs](config/test.exs) com o novo valor
- Execute o seguinte comando para se certificar de que a imagem foi criada com sucesso: `nerdctl ps`, a saída deve ser algo próximo dê:
`CONTAINER ID    IMAGE                                COMMAND                   CREATED          STATUS    PORTS                   NAMES
98c1cf73c852    docker.io/library/database:latest    "docker-entrypoint.s…"    2 minutes ago    Up        0.0.0.0:81->5432/tcp    database-container`
- [Documentação ContainerD](https://containerd.io/docs/)
- [Documentação Docker](https://docs.docker.com/get-started/)

## Reinicializar o banco de dados local
- Caso tenha optado pelo uso do Nerdctl basta executar o arquivo `start-locally.sh`, ou executar os seguintes comandos:
    - `nerdctl [ou docker] stop database-container`
    - `nerdctl [ou docker] rm database-container`
    - `nerdctl [ou docker] run -d --name database-container -p 81:5432 database`

## Criar tabelas no banco de dados
- `mix ecto.migrate`
- [Documentação Ecto SQL](https://hexdocs.pm/ecto_sql/Ecto.Migration.html)

## Instalar dependências do Elixir
- `mix deps.get`

## Executar testes
- `mix test`

## Iniciar ambiente de desenvolvimento
- `mix phx.server`
- A API deve estar disponível em [`localhost:4000`](http://localhost:4000)

## Verificar rotas existentes
- `mix phx.routes`