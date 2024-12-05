# Iam

# 構成
- ruby  3.2.1
- rails 7.0.4.2
- postgres  latest

# Dockerコマンド
 - docker compose run --rm --no-deps web rails new . --force --database=postgresql
 - docker compose build
 - docker compose run --rm web rails db:create
 - docker compose up
