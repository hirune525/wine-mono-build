# Dockerfile
FROM ubuntu:22.04

# Visual Studio version
ARG VS_VERSION=17.9
# VSTest version (パッチ番号は固定)
ARG VSTEST_VERSION=${VS_VERSION}.0

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

# Mono 公式リポジトリを登録 (VS2022相当の環境が必要なのでpreview版)
RUN wget https://download.mono-project.com/repo/xamarin.gpg -O /usr/share/keyrings/mono-official.asc && \
    echo "deb [arch=amd64,i386 signed-by=/usr/share/keyrings/mono-official.asc] https://download.mono-project.com/repo/ubuntu preview jammy main" \
    > /etc/apt/sources.list.d/mono-official-preview.list

# 必要パッケージを一括インストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        "mono-complete=8.*" \
        "msbuild=${VS_VERSION}.*" \
        "nuget=6.*" \
        referenceassemblies-pcl \
        wine64 \
        wine32 \
        winetricks \
        unzip \
        p7zip-full \
        cabextract && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# VS Test Platform (vstest.console) を取得
RUN wget -q https://github.com/microsoft/vstest/releases/download/v${VSTEST_VERSION}/vstest.${VSTEST_VERSION}.zip -O /tmp/vstest.zip && \
    unzip /tmp/vstest.zip -d /opt/vstest && \
    rm /tmp/vstest.zip && \
    echo '#!/bin/bash\nexec mono /opt/vstest/vstest.console.exe "$@"' > /usr/local/bin/vstest.console && \
    chmod +x /usr/local/bin/vstest.console

# ソースをコピー
WORKDIR /usr/local/src
COPY src/ .

# デフォルトシェル
CMD ["/bin/bash"]
