# Sorteio API

## Dependências
- Instale a linguagem Elixir: https://elixir-lang.org/install.html (Versão 1.17.3)
    - Verifique a instalação através do comando `elixir -v` o qual deve retornar a versão da linguagem instalada
- Instale o framework Phoenix através do comando: `mix archive.install hex phx_new`
- Instale as dependências do projeto Elixir através do comando `mix deps.get`
- Instale Docker, Nerdctl, ou qualquer outro gerenciador de containers

## Criação do banco de dados local
- Caso tenha optado pelo uso do Nerdctl basta executar o arquivo `start-locally.sh`. Caso contrário execute os seguintes comandos:
    - `nerdctl [ou docker] build --file ./Dockerfile.database -t database .` => Build da imagem com o banco de dados
    - `nerdctl [ou docker] run -d --name database-container -p 81:5432 database`, => Inicialização do container utilizando a porta 81 (certifique-se de que ela não esteja sendo utilizada por nenhuma outra aplicação)
        - Caso a porta 81 não esteja disponível modifique para uma válida disponível e atualize os arquivos [config/dev.exs](config/dev.exs) e [config/test.exs](config/test.exs) com o novo valor
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

## Iniciar API local
- `mix phx.server`
- Lembre-se de iniciar o banco de dados local
- A API deve estar disponível em [`localhost:4000`](http://localhost:4000)

## Verificar rotas existentes
- `mix phx.routes`

## Endpoints
### Verifica a saúde da API, incluindo suas dependências
- GET    /api/health                 LotteryWeb.HealthCheck.HealthCheckontroller :index
### Busca o usuário pelo seu ID
- GET    /api/v1/user/:id            LotteryWeb.Users.UserV1Controller :show
### Cria um novo usuário
- POST   /api/v1/user                LotteryWeb.Users.UserV1Controller :create
    - Body example:
    {
        "name": "João",
        "email": "email@gmail.com",
        "password": "jpmc2106"
    }
### Atualiza as informações do usuário
- PUT    /api/v1/user/:id            LotteryWeb.Users.UserV1Controller :update
    - Body example:
    {
		"email": "email@gmail.com"
    }   
### Busca um sorteio pelo seu id
- GET    /api/v1/event/:id           LotteryWeb.Events.EventV1Controller :show
### Cria um novo sorteio
- POST   /api/v1/event               LotteryWeb.Events.EventV1Controller :create
    - Body example:
    {
        "user_id": 1,
        "name": "Event",
        "date": "2024-10-12 10:00:00.00Z"
    }
### Busca a lista de usuários participantes de um sorteio pelo seu id
- GET    /api/v1/participation?event_id={ID_DO_SORTEIO}       LotteryWeb.Participations.ParticipationsV1Controller :index
### Adiciona um usuário a um sorteio
- POST   /api/v1/participation       LotteryWeb.Participations.ParticipationsV1Controller :create
    - Body example:
    {
        "user_id": 1,
        "event_id": 1
    }
### Busca o vencedor de um sorteio, se houver
- GET /api/v1/winner                 LotteryWeb.Winners.WinnerV1Controller :index

## Worker que realiza os sorteios
- Lottery.Job.Winners.WinnersJob
