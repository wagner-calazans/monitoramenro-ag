# Projeto de Monitoramento de Agentes (monitoramenro-ag)

Este projeto é uma solução de monitoramento que utiliza agentes para coletar métricas de disponibilidade de serviços (via ping e testes web) e exibi-las em um painel do Grafana. O sistema é containerizado com Docker e utiliza um banco de dados SQLite para armazenamento local.

## Visão Geral

O projeto consiste em três componentes principais:

1. **Agente de Ping (`ping-agent`)**: Realiza testes de ping em hosts especificados para verificar a conectividade.
2. **Agente de Teste Web (`web-test-agent`)**: Realiza requisições HTTP em URLs especificadas para verificar a disponibilidade de serviços web.
3. **Grafana**: Exibe os dados coletados em painéis (dashboards) personalizados.

O sistema é orquestrado usando `docker-compose`, facilitando a execução e o gerenciamento dos componentes.




### Diagrama de Arquitetura

+-------------------+       +-------------------+       +-------------------+
|   Ping Agent      |       |   Web Test Agent  |       |     Grafana       |
|  (ping_script.sh) |       |  (web_script.sh)  |       |                   |
+-------------------+       +-------------------+       +-------------------+
          |                         |                           |
          |                         |                           |
          v                         v                           |
+-------------------+       +-------------------+               |
|   SQLite Database |<------|   SQLite Database |<--------------+
|  (monitoramento.db)       |  (monitoramento.db)               |
+-------------------+       +-------------------+               |
          ^                         ^                           |
          |                         |                           |
          +-------------------------+---------------------------+


Descrição dos Componentes
Agente de Ping (ping-agent):

Função: Realiza testes de ping em hosts especificados.

Tecnologias: Script Bash (ping_script.sh), Docker.

Saída: Armazena os resultados no banco de dados SQLite (monitoramento.db).

Agente de Teste Web (web-test-agent):

Função: Realiza requisições HTTP em URLs especificadas para verificar a disponibilidade de serviços web.

Tecnologias: Script Bash (web_script.sh), Docker.

Saída: Armazena os resultados no banco de dados SQLite (monitoramento.db).

Grafana:

Função: Exibe os dados coletados em painéis (dashboards) personalizados.

Tecnologias: Grafana, Docker.

Configuração: Utiliza um arquivo datasource.yml para conectar ao banco de dados SQLite e um arquivo JSON para definir o painel.

Banco de Dados SQLite:

Função: Armazena os dados coletados pelos agentes.

Localização: database/monitoramento.db.

Inicialização: O banco de dados é inicializado com o script init.sql.

Orquestração com Docker Compose:

Função: Gerencia a execução dos containers dos agentes e do Grafana.

Arquivo de Configuração: docker-compose.yml.

Como Executar o Projeto
Pré-requisitos
Docker e Docker Compose instalados.

Acesso à internet para baixar as imagens Docker.

Passos para Execução
Clone o repositório:

bash
Copy
git clone https://github.com/seu-usuario/monitoramenro-ag.git
cd monitoramenro-ag
Inicie os containers com Docker Compose:

bash
Copy
docker-compose up -d
Acesse o Grafana:

Abra o navegador e acesse http://localhost:3000.

Use as credenciais padrão (admin/admin) ou as configuradas no docker-compose.yml.

Verifique os painéis:

O painel "Agente de Monitoramento" já estará configurado para exibir os dados coletados.

Estrutura do Projeto
plaintext
Copy
monitoramenro-ag/
├── database
│   ├── init.sql                # Script de inicialização do banco de dados
│   └── monitoramento.db        # Banco de dados SQLite
├── docker-compose.yml          # Configuração do Docker Compose
├── grafana
│   └── provisioning
│       ├── dashboards
│       │   ├── Agente de Monitoramento.png          # Print do painel
│       │   └── Agente de monitoramento web 2-1741565249315.json  # Definição do painel
│       └── datasources
│           └── datasource.yml  # Configuração da fonte de dados do Grafana
├── ping-agent
│   ├── Dockerfile              # Dockerfile para o agente de ping
│   ├── Dockerfile.original     # Dockerfile original (backup)
│   └── ping_script.sh          # Script de monitoramento via ping
├── README.md                   # Documentação do projeto
└── web-test-agent
    ├── Dockerfile              # Dockerfile para o agente de teste web
    ├── Dockerfile.Default      # Dockerfile original (backup)
    └── web_script.sh           # Script de monitoramento web
