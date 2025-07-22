# Dockerfile
FROM ubuntu:22.04

# 文字化け防止
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8

# 非対話モードで apt を使う
ENV DEBIAN_FRONTEND=noninteractive

# Wine 用の i386 アーキテクチャ追加
RUN dpkg --add-architecture i386 && apt-get update

# 必要パッケージを一括インストール
RUN apt-get install -y --no-install-recommends \
    git \
    mono-complete \
    msbuild \
    referenceassemblies-pcl \
    wine64 \
    wine32 \
    winetricks \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# デフォルトシェル
CMD ["/bin/bash"]
