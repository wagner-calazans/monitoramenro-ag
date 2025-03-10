#!/bin/bash

# Caminho do banco de dados SQLite
DB_PATH=${DB_PATH:-/database/monitoramento.db}

# Cria a tabela se não existir
sqlite3 $DB_PATH "CREATE TABLE IF NOT EXISTS web_test_results (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    url TEXT NOT NULL,
    status_code INTEGER,
    load_time REAL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);"

# URLs para testar
URLS=("https://google.com" "https://youtube.com" "https://rnp.br")

while true; do
    for url in "${URLS[@]}"; do
        echo "Testando $url..."
        start_time=$(date +%s%N)
        response=$(curl -o /dev/null -s -w "%{http_code}\n" $url)
        end_time=$(date +%s%N)
        load_time=$(echo "scale=2; ($end_time - $start_time) / 1000000000" | bc)

        if [ $? -eq 0 ]; then
            echo "Código de retorno: $response"
            echo "Tempo de carregamento: $load_time segundos"

            # Insere os resultados no banco de dados
            sqlite3 $DB_PATH "INSERT INTO web_test_results (url, status_code, load_time) VALUES ('$url', $response, $load_time);"
        else
            echo "Erro ao acessar $url"
        fi
        echo ""
    done
    sleep 60  # Espera 1 minuto antes de repetir
done
