FROM alpine:latest

# Instala dependências: curl, bash e sqlite3
RUN apk add --no-cache curl bash sqlite

# Copia o script para o container
COPY web_script.sh /web_script.sh

# Torna o script executável
RUN chmod +x /web_script.sh

# Executa o script
CMD ["/web_script.sh"]
