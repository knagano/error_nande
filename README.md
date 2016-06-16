# ErrorNande

    アイエエエエ! エラー!? エラーナンデ!?

例外を整形して文字列1行で返す

全てを1行に納めているので、ログに出力したとき、grep結果に全ての情報が含まれているため、エラーがナンデか追いやすい


文字列には、クラス名、メッセージ、バックトレースの1行目が含まれる

```
> ErrorNande.nande(error1)
=> "#<ErrorClass: error message> at path/to/code.rb:42:in `func'"
```

例外に re-raise による `cause` が付いている場合、再帰的に文字列化される

```
> ErrorNande.nande(error2)
=> "#<ErrorClass1: error message1> at path/to/code1.rb:42:in `func1' (cause #<ErrorClass2: error message2> at path/to/code2.rb:242:in `func2') (cause #<ErrorClass3: error message3> at path/to/code3.rb:242:in `func3')"
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'error_nande'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install error_nande

## Contributing

1. Fork it ( https://github.com/knagano/error_nande/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
