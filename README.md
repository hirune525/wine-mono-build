# wine mono build

linux 上で .net framework で実装されたアプリケーションをビルド・テストする検証用環境

## 起動

```bash
# イメージ作成
docker build -t wine-mono-build:latest .
# 起動
docker run --rm -it wine-mono-build:latest /bin/bash
# msbuild
msbuild DotnetConsoleApp/DotnetConsoleApp.sln /restore /p:RestorePackagesConfig=true /p:Configuration=Debug
# test
vstest.console DotnetConsoleApp/DotnetConsoleApp.Tests/bin/Debug/DotnetConsoleApp.Tests.dll
```