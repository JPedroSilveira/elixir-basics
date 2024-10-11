# Sorteio API

## Dependências
- Instale a linguagem Elixir: https://elixir-lang.org/install.html (Versão 1.17.3)
    - Verifique a instalação com o comando `elixir -v`
- Instale Docker, Nerdctl, ou qualquer outro gerenciador de containers

## Criação do banco de dados local
- Caso tenha optado pelo uso do Nerdctl basta executar o arquivo `start-locally.sh`, ou rodar manualmente:
    - Faça o build da image do banco de dados: `nerdctl [ou docker] build --file ./Dockerfile.database -t database .`
    - Inicie o container com o banco de dados: `nerdctl [ou docker] run -d --name database-container -p 81:5432 database`, note que porta 81 está sendo utilizada, certifique-se de que ela não esteja sendo utilizada por nenhuma outra aplicação
- Execute o seguinte comando para se certificar de que a imagem foi criada com sucesso: `nerdctl ps`, a saída deve ser algo próximo dê:
`CONTAINER ID    IMAGE                                COMMAND                   CREATED          STATUS    PORTS                   NAMES
98c1cf73c852    docker.io/library/database:latest    "docker-entrypoint.s…"    2 minutes ago    Up        0.0.0.0:81->5432/tcp    database-container`



