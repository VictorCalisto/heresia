# Fixe a sua versao de rubi ao subir o projeto
FROM ruby:3.3.0

# Atualizar os pacotes e instalar as dependências
RUN apt-get update -y

# Instala dependencias
RUN apt-get install -qy --no-install-recommends \
    curl \
    gpg \
    autoconf  \
    bison  \
    build-essential  \
    libssl-dev  \
    libyaml-dev  \
    libreadline6-dev  \
    zlib1g-dev  \
    libncurses5-dev  \
    libffi-dev  \
    libgdbm6  \
    libgdbm-dev \
    libpq-dev \
    postgresql \ 
    postgresql-client

# Instalar o Rails
RUN /bin/bash -l -c "gem install rails"

# Baixa o Node.js
RUN curl -fsSL https://nodejs.org/dist/v22.4.1/node-v22.4.1-linux-x64.tar.gz -o node-v22.4.1-linux-x64.tar.gz \
    && tar -zxvf node-v22.4.1-linux-x64.tar.gz -C /usr/local --strip-components=1 \
    && rm node-v22.4.1-linux-x64.tar.gz

# Define o diretório de trabalho
WORKDIR /app
COPY . /app
# Instala o node
RUN if [ -f package.json ]; then \
      npm install; \
    else \
      npm init -y && npm install; \
    fi
# Instala o Bundler
RUN if [ -f Gemfile ]; then \
      bundle install -j $(nproc) && \
      rails assets:precompile; \
    fi
# Limpar o cache do apt-get e outros arquivos temporários
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Tratamento de erros
RUN chmod +x /app/docker-entrypoint.sh
ENTRYPOINT ["sh","/app/docker-entrypoint.sh"]

# Torna o container debugavel
CMD ["sh", "-c", "rails s -p 3000 -b 0.0.0.0"]