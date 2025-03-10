FROM alpine:latest

# Instala dependências: ping, bash e sqlite3
RUN apk add --no-cache iputils bash sqlite

# Copia o script para o container
COPY ping_script.sh /ping_script.sh

# Torna o script executável
RUN chmod +x /ping_script.sh

# Executa o script
CMD ["/ping_script.sh"]
