# Monitoramento de Agentes

Este projeto é uma solução de monitoramento que utiliza agentes para coletar métricas de disponibilidade de serviços (via ping e testes web) e exibi-las em um painel do Grafana. O sistema é containerizado com Docker e utiliza um banco de dados SQLite para armazenamento local.

## Visão Geral

O projeto consiste em três componentes principais:

- **Agente de Ping (**``**)**: Realiza testes de ping em hosts especificados para verificar a conectividade.
- **Agente de Teste Web (**``**)**: Realiza requisições HTTP em URLs especificadas para verificar a disponibilidade de serviços web.
- **Grafana**: Exibe os dados coletados em painéis (dashboards) personalizados.

O sistema é orquestrado usando `docker-compose`, facilitando a execução e o gerenciamento dos componentes.

---

## Estrutura do Projeto

```plaintext
monitoramento-agentes/
├── database/
│   ├── init.sql                 # Script de inicialização do banco de dados
│   ├── init.sql.original        # Cópia original do script SQL inicial
│   ├── monitoramento.db         # Banco de dados SQLite para monitoramento
│   └── viaipe.db                # Banco de dados SQLite para o ViaIPE
│
├── docker-compose.yml           # Configuração principal do Docker Compose
├── docker-compose.yml.second    # Configuração secundária do Docker Compose
│
├── grafana/
│   └── provisioning/
│       ├── dashboards/
│       │   ├── Agente de Monitoramento.png    # Imagem do dashboard
│       │   └── monitoramento_dashboard.json  # Dashboard do Grafana
│       └── datasources/
│           ├── datasource.yml                 # Configuração da fonte de dados
│           └── datasource.yml.second          # Configuração secundária da fonte de dados
│
├── ping-agent/
│   ├── Dockerfile              # Dockerfile para construir a imagem do agente de ping
│   ├── Dockerfile.original     # Cópia original do Dockerfile
│   ├── ping_script.sh          # Script para executar o ping
│   └── ping_script.sh.original # Cópia original do script de ping
│
├── viaipe-agent/
│   ├── Dockerfile             # Dockerfile do agente ViaIPE
│   ├── Dockerfile.copy        # Cópia do Dockerfile
│   ├── requirements.txt       # Dependências Python
│   ├── viaipe_collector.py    # Script Python de coleta do ViaIPE
│   ├── viaipe_collector.sh    # Script shell do coletor ViaIPE
│   └── viaipe_script.sh       # Script shell do agente ViaIPE
│
├── web-test-agent/
│   ├── Dockerfile              # Dockerfile do agente de teste web
│   ├── Dockerfile.Default      # Cópia padrão do Dockerfile
│   ├── web_script.sh           # Script de testes web
│   └── web_script.sh.original  # Cópia original do script de teste web
│
└── README.md                   # Documentação do projeto
```

---

## Diagrama de Arquitetura

```plaintext
+-------------------+    +-------------------+    +-------------------+
|    Ping Agent    |    | Web Test Agent   |    |      Grafana     |
| (ping_script.sh) |    | (web_script.sh)  |    |                  |
+-------------------+    +-------------------+    +-------------------+
          |                      |                      |
          |                      |                      |
          v                      v                      |
+-------------------+    +-------------------+          |
|  SQLite Database |<---|  SQLite Database |<----------+
| (monitoramento.db) |    | (monitoramento.db) |
+-------------------+    +-------------------+
```

---

## Como Usar

### 1. Configuração do Docker Compose

- Utilize o arquivo `docker-compose.yml` para subir os contêineres necessários.
- Se necessário, utilize `docker-compose.yml.second` para configurações alternativas.

```bash
docker-compose up -d
```

### 2. Acesso ao Grafana

- Abra o navegador e acesse: `http://localhost:3000`
- Use as credenciais padrão (`admin/admin`) ou as configuradas no `docker-compose.yml`

### 3. Verifique os Painéis

- O painel **"Agente de Monitoramento"** estará configurado para exibir os dados coletados.

---

## Descrição dos Componentes

### **Agente de Ping (**``**)**

- **Função**: Realiza testes de ping para verificar conectividade.
- **Tecnologias**: Script Bash (`ping_script.sh`), Docker.
- **Saída**: Armazena os resultados no banco SQLite (`monitoramento.db`).

### **Agente de Teste Web (**``**)**

- **Função**: Realiza requisições HTTP para verificar a disponibilidade dos serviços web.
- **Tecnologias**: Script Bash (`web_script.sh`), Docker.
- **Saída**: Armazena os resultados no banco SQLite (`monitoramento.db`).

### **Grafana**

- **Função**: Exibe os dados coletados em painéis personalizados.
- **Tecnologias**: Grafana, Docker.
- **Configuração**: Usa `datasource.yml` para conectar ao SQLite e `monitoramento_dashboard.json` para definir os painéis.

### **Banco de Dados SQLite**

- **Função**: Armazena os dados coletados pelos agentes.
- **Localização**: `database/monitoramento.db`
- **Inicialização**: O banco é configurado com `init.sql`.

---

## Contribuição

Se deseja contribuir para este projeto, fique à vontade para abrir **issues** ou **pull requests**.

---

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).

