# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Memo備忘

Railsのコンテナを起動してRailsのプロジェクトを作成するコマンド
$ docker-compose run web rails new . --force --database=mysql

Railsイメージのビルド実行コマンド
$ docker-compose build

rm tmp/pids/server.pid

config/database.ymlの修正内容
default内の項目を修正
password: password
host: db

コンテナをデタッチドモード（バックグラウンド）で実行するコマンド
$ docker-compose up -d

RailsのコンテナでDB作成のタスクを実行するコマンド
$ docker-compose run web bundle exec rake db:create

docker-compose run web bundle exec rake db:migrate

deviseのinstall用のコマンド
docker-compose bundleを実行した後
docker-compose up -dでコンテナを再起動したあとに下記を実行
docker-compose exec web bundle exec rails g devise:install

deviseでのモデル作成
docker-compose run web bundle exec rails g devise Admin

deviseでコントローラ作成
docker-compose run web bundle exec rails g devise:controllers admins

deviseでのview作成
docker-compose run web bundle exec rails g devise:views

model作成
docker-compose run web bundle exec rails g model Locale

controller作成
docker-compose run web bundle exec rails g controller admins

コンテナのbashに接続
docker exec -it  qr-timecard-ver2_web_1 bash
bundle exec rails c