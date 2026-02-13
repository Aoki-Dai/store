# RUBY_VERSIONが.ruby-versionのRubyバージョンと一致していることを確認してください
ARG RUBY_VERSION=4.0.1
FROM ghcr.io/rails/devcontainer/images/ruby:$RUBY_VERSION

# bindingが常に0.0.0.0になるようにします
# コンテナの外部からアクセスできるように、サーバーをコンテナのすべてのIPアドレスにバインドします。
ENV BINDING="0.0.0.0"
