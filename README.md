# [RailsによるアジャイルWebアプリケーション開発](https://www.amazon.co.jp/dp/B07BDHD7YM/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1)のアプリ 

開発環境やテスト環境を動作させるためには、[PAY.JP](https://pay.jp/)への登録が必要。
ルートに.envファイルを置き、PAY.JPのキーを次のように記述しておくこと。

```ruby:.env
STRIPE_API_PUBLIC=pk_test_your_pay_jp_account
STRIPE_API_SECRET=sk_test_your_pay_jp_account
```

Rspecを動かすと初回実行時にPAY.JPへの問い合わせがVCRによって保存され、二回目以降はモック化される。
