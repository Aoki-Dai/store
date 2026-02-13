.PHONY: help setup install db-setup db-create db-migrate db-seed db-reset \
        test test-system server console routes lint lint-fix clean \
        assets-precompile assets-clean security-check

# デフォルトターゲット
.DEFAULT_GOAL := help

# 色設定
YELLOW := \033[33m
RESET := \033[0m

help: ## ヘルプメッセージを表示
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-20s$(RESET) %s\n", $$1, $$2}'

setup: install db-setup ## 初期セットアップ（依存関係のインストールとデータベースのセットアップ）

install: ## gemの依存関係をインストール
	bundle install

db-setup: db-create db-migrate db-seed ## データベースのセットアップ（作成、マイグレーション、シード）

db-create: ## データベースを作成
	bin/rails db:create

db-migrate: ## データベースマイグレーションを実行
	bin/rails db:migrate

db-seed: ## 初期データをシード
	bin/rails db:seed

db-reset: ## データベースをリセット（削除、作成、マイグレーション、シード）
	bin/rails db:reset

db-rollback: ## 最後のマイグレーションをロールバック
	bin/rails db:rollback

test: ## 全テストを実行
	bin/rails test

test-system: ## システムテストを実行
	bin/rails test:system

server: ## Railsサーバーを起動
	bin/rails server

console: ## Railsコンソールを起動
	bin/rails console

routes: ## 全ルートを表示
	bin/rails routes

lint: ## リンターを実行（rubocop、brakeman、bundler-audit）
	bundle exec rubocop
	bundle exec brakeman -q
	bundle exec bundler-audit check --update

lint-fix: ## rubocopの自動修正を実行
	bundle exec rubocop -A

security-check: ## セキュリティチェックを実行（brakeman、bundler-audit）
	bundle exec brakeman -q
	bundle exec bundler-audit check --update

assets-precompile: ## アセットをプリコンパイル
	bin/rails assets:precompile

assets-clean: ## コンパイル済みアセットを削除
	bin/rails assets:clobber

clean: ## 一時ファイルを削除
	rm -rf tmp/cache
	rm -rf log/*.log
	rm -rf tmp/pids

logs: ## 開発ログをtail表示
	tail -f log/development.log

kamal-setup: ## Kamalデプロイメントをセットアップ
	bundle exec kamal setup

kamal-deploy: ## Kamalでデプロイ
	bundle exec kamal deploy
