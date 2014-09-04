# Anime Kansai
アニメの放送を10分前に通知するTwitterボットです。

## 使い方
AnimeKansaiを利用するためには以下の準備が必要です。

1. アニメの放送情報をtweetするTwitterアカウント
2. https://dev.twitter.com/ から登録できるTwitterアプリケーション
3. 2のアプリケーションが1のアカウントでtweetするための access token
4. アニメの放送情報源になる[しょぼいカレンダー](http://cal.syoboi.jp/)のアカウント
  - http://cal.syoboi.jp/uc からチャンネル設定をしておくと良いでしょう

1~4の情報を環境変数にセットして起動すると、10分に一度[しょぼいカレンダー](http://cal.syoboi.jp/)
をチェックし、10分以内に放送されるアニメのタイトルをtweetします。

### 環境変数一覧

AnimeKansaiを起動するために必要な環境変数一覧です。

- `AK_SYOBOCAL_ID` しょぼいカレンダーのユーザアカウント
- `AK_API_KEY` TwitterアプリケーションのAPI Key
- `AK_API_SECRET` TwitterアプリケーションのAPI Secret
- `AK_TOKEN` Twitterのアプリケーションごとに作られるAPI Key
- `AK_TOKEN_SECRET` Twitterのアプリケーションごとに作られるAPI Secret

## 動いているアカウント

- [AnimeKansai](https://twitter.com/animekansai)

