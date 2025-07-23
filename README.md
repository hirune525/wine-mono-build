# wine mono build

linux 上で .net framework で実装されたアプリケーションをビルドする検証用。

## 起動

```bash
# イメージ作成
docker build -t wine-mono-build:latest .
# 起動
docker run --rm -it wine-mono-build:latest /bin/bash
```