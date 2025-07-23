# Dockerfile
FROM ubuntu:22.04

# VSTest version
ENV VSTEST_VERSION=17.14.1

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

# 個別環境の文字コード設定
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8

# https で apt を使うための前提パッケージ
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        gnupg \
        wget

# Mono 公式リポジトリを登録
RUN gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list

# 必要パッケージを一括インストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        mono-complete \
        msbuild \
        mono-roslyn \
        nuget \
        referenceassemblies-pcl \
        wine64 \
        wine32 \
        winetricks \
        unzip \
        p7zip-full \
        cabextract && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ソースをコピー
WORKDIR /usr/local/src
COPY src/ .

# VS Test Platform (vstest.console) をnugetから取得してmono上で実行できるようにする
RUN mkdir -p /opt/vstest && \
    nuget install Microsoft.TestPlatform -Version ${VSTEST_VERSION} -OutputDirectory /opt/vstest && \
    { \
        echo '#!/bin/bash'; \
        echo 'set -e'; \
        echo 'VSTEST_DIR=/opt/vstest/Microsoft.TestPlatform.${VSTEST_VERSION}/tools/net462/Common7/IDE/Extensions/TestPlatform'; \
        echo 'exec mono "${VSTEST_DIR}/vstest.console.exe" "$@"'; \
    } > /usr/local/bin/vstest.console && \
    chmod +x /usr/local/bin/vstest.console

# デフォルトシェル
CMD ["/bin/bash"]
