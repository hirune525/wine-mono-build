# Dockerfile
FROM ubuntu:22.04

# 非対話モードで apt を使う
ENV DEBIAN_FRONTEND=noninteractive

# Wine 用の i386 アーキテクチャ追加
RUN dpkg --add-architecture i386

# 文字化け防止
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        language-pack-ja \
        locales && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8

# https で apt を使うための前提パッケージ
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        gnupg \
        wget

# Mono 公式リポジトリを登録
RUN wget https://download.mono-project.com/repo/xamarin.gpg -O /usr/share/keyrings/mono-official.asc && \
    echo "deb [arch=amd64,i386 signed-by=/usr/share/keyrings/mono-official.asc] https://download.mono-project.com/repo/ubuntu stable jammy main" \
    > /etc/apt/sources.list.d/mono-official-stable.list

# 必要パッケージを一括インストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        mono-complete \
        msbuild \
        referenceassemblies-pcl \
        wine64 \
        wine32 \
        winetricks \
        unzip \
        p7zip-full \
        cabextract && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# デフォルトシェル
CMD ["/bin/bash"]
