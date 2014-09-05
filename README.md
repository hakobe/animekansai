# Anime Kansai
アニメの放送を10分前に通知するTwitterボットです。

10分に一度[しょぼいカレンダー](http://cal.syoboi.jp/)
をチェックし、10分以内に放送されるアニメのタイトルをtweetします。

設定を変更すれば、関西以外のアニメ情報もtweetできます。

## 使い方

### 準備
AnimeKansaiを利用するためには以下の準備が必要です。

1. アニメの放送情報をtweetするTwitterアカウント
2. https://dev.twitter.com/ から登録できるTwitterアプリケーション
3. 2のアプリケーションが1のアカウントでtweetするための access token
4. アニメの放送情報源になる[しょぼいカレンダー](http://cal.syoboi.jp/)のアカウント
  - http://cal.syoboi.jp/uc からチャンネル設定をしておくと良いでしょう

### 環境変数一覧

AnimeKansaiを起動するために必要な環境変数一覧です。

- `AK_SYOBOCAL_ID` しょぼいカレンダーのユーザアカウント
- `AK_API_KEY` TwitterアプリケーションのAPI Key
- `AK_API_SECRET` TwitterアプリケーションのAPI Secret
- `AK_TOKEN` tweetするユーザの access token
- `AK_TOKEN_SECRET` tweetするユーザの access token secret

### 起動

```
$ npm install
$ $(npm bin)/coffee animekansai.coffee
```

### Herokuを使う

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/hakobe/animekansai)

そのままでは動作しないので、以下のように起動しましょう。(animekansaiというアプリ名を使っている場合)

```
$ heroku git:clone -a animekansai
$ cd animekansai
$ heroku scale bot=1
```


## 動いているアカウント

- [AnimeKansai](https://twitter.com/animekansai)

