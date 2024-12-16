#Setando a imagem base
FROM ruby:2.7.7

#Instalando o nodejs e o postgresql client
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

#Setando o diretório de trabalho da aplicação
WORKDIR /app

#Copiando o Gemfile e o Gemfile.lock para o diretório de trabalho
COPY Gemfile Gemfile.lock ./

#Instalando as dependências
RUN bundle install

#Copiando o restante dos arquivos para o diretório de trabalho
COPY . .

#Gerando uma master key dentro do container
RUN rm ./config/credentials.* && \
    echo "Master Key Generate" && \
    echo "Master Key" > ./config/master.key && \
    rails credentials:edit

#Expondo a porta 3000
EXPOSE 3000

#Comando para iniciar o servidor
CMD ["rails", "server", "-b", "0.0.0.0"]