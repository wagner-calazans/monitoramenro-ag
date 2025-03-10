#!/bin/bash

# Caminho do banco de dados SQLite
DB_PATH=${DB_PATH:-/database/monitoramento.db}

# Cria a tabela se não existir
sqlite3 $DB_PATH "CREATE TABLE IF NOT EXISTS ping_results (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    target TEXT NOT NULL,
    rtt_avg REAL,
    packet_loss REAL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);"

# Endereços para testar
TARGETS=("google.com" "youtube.com" "rnp.br")

while true; do
    for target in "${TARGETS[@]}"; do
        echo "Testando ping para $target..."
        result=$(ping -c 4 $target | awk -F'/' 'END {print $5 " " $7}')
        rtt_avg=$(echo $result | awk '{print $1}')
        packet_loss=$(echo $result | awk '{print $2}')

        # Verifica se os valores são válidos
        if [[ -z "$rtt_avg" || -z "$packet_loss" ]]; then
            echo "Erro: Não foi possível calcular rtt_avg ou packet_loss para $target."
            continue
        fi

        # Insere os resultados no banco de dados
        sqlite3 $DB_PATH "INSERT INTO ping_results (target, rtt_avg, packet_loss) VALUES ('$target', $rtt_avg, $packet_loss);"
        echo ""
    done
    sleep 60  # Espera 1 minuto antes de repetir
done
