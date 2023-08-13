# Nico

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

### アカウント作成方法
1. `$ iex -S mix phx.server`
2. `user_params = %{"email" => "メールアドレス", "password" => "パスワード"}`
3. `Nico.Accouts.register_user(user_params)`

### ログ
- `Logger.info("info message from PageController")`
  - consoleに出力される (2023/8/17)
- 参照 https://qiita.com/kikuyuta/items/b4d6a4e0ea591281f920

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
