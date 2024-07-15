#!/bin/sh

# Configuração do script bash
set +euvx
IFS=$'\n\t'

# Verifica se o Gemfile existe no diretório Raiz
if [ -e "./Gemfile" ];
then
  echo "Já existe um Gemfile no diretório Raiz. Executando create e migrate ..."
  rails db:create
  rails db:migrate
  if rails db:version 2>/dev/null; then
    echo "O banco de dados já esta pronto. Nenhum comando de seed será executado."
  else
    rails db:seed
    echo "Comandos de seed concluídos, o banco de dados está pronto."
  fi
else
  echo "Nenhum Gemfile encontrado. Criando um novo projeto Rails..."

  # Copia os arquivos para a pasta /tmp
  cp Dockerfile docker-compose.yml .gitignore .dockerignore README.md /tmp

  # Crie um novo projeto Rails
  rails new . --css=tailwind --javascript=webpack --database=postgresql --webpack=vue --skip-hotwire &&
  bundle install -j $(nproc) &&
  bundle add vuejs-rails &&
  bundle add tailwindcss-rails &&
  echo "//= require vue" >> app/assets/javascripts/application.js
  echo "//= require vue-router" >> app/assets/javascripts/application.js
  echo "//= require vue-resource" >> app/assets/javascripts/application.js
  echo "//= require vuex" >> app/assets/javascripts/application.js
  sed -i '/<%= javascript_include_tag .application. %>/d' app/views/layouts/application.html.erb
  sed -i '/<\/body>/i <%= javascript_include_tag "application" %>' app/views/layouts/application.html.erb
  npm init -y
  npm install --save-dev webpack webpack-cli &&
  npx webpack-cli init -n
  npm install vue
  npm install --save-dev vue-loader vue-template-compiler
  npm install tailwindcss postcss autoprefixer &&
  npx tailwindcss init
  npm run build
  rails tailwindcss:watch
  rails assets:precompile
  # Copia os arquivos da pasta /tmp de volta para a pasta atual, sobrescrevendo os existentes
  cp /tmp/Dockerfile /tmp/docker-compose.yml /tmp/.gitignore /tmp/.dockerignore /tmp/README.md .

  # Limpa a pasta /tmp
  rm /tmp/Dockerfile /tmp/docker-compose.yml /tmp/.gitignore /tmp/.dockerignore /tmp/README.md
  
  echo "Novo projeto Rails foi criado no diretório Raiz."
fi

# Limpa o PID
rm -f /app/tmp/pids/server.pid
echo "Arquivo server.pid deletado. Subindo servidor rails ...."

# Executa o comando principal (a aplicação Rails)
exec "$@"

