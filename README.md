# AlpacaAPI.jl

## The Julia Alpaca API Wrapper

AlpacaAPI.jl is a wrapper built entirely in Julia for [Alpaca, the modern platform for algorithmic trading](https://alpaca.markets/docs/api-documentation/api-v2/).

**Currently a work in progress! As I am merely a single devleoper working in my free time this project might take a little while.**

## Getting Started

To use the Alpaca API, you'll need to first [get your API key after creating an account with Alpaca](https://app.alpaca.markets/).

After that, you'll need to put your API Key ID and your Secret Key and put them into environment variables called `APCA_API_KEY_ID` and `APCA_API_SECRET_KEY`, respectively. By default AlpacaAPI.jl assumes you're using a **PAPER** account, but you can also set the `APCA_ENDPOINT` environment variable to "LIVE" or "PAPER" to set the endpoint to **LIVE** or **PAPER**, respectively.

An easy way to set this up is to add the following lines to your `~/.julia/config/startup.jl` script.

```julia
ENV["APCA_ENDPOINT"]        = "PAPER"
ENV["APCA_API_KEY_ID"]      = "YOUR-PAPER-KEY-HERE"
ENV["APCA_API_SECRET_KEY"]  = "YOUR-PAPER-SECRET-HERE"
```

> Keep in mind that your **PAPER** account and your **LIVE** accounts have **different keys!**

After this initial setup, it's easy to start using AlpacaAPI

```julia
julia> using AlpacaAPI

julia> AlpacaAPI.get_account()
Account
-------
* account_blocked         : false
* account_number          : MYACCOUNTNUMBER
* buying_power            : 9823.12
* cash                    : 4130.54
* created_at              : 2020-01-01T01:02:03.456789Z
* currency                : USD
* daytrade_count          : 0
* daytrading_buying_power : 0.0
* equity                  : 11132.58
* id                      : MY-ACCOUNT-UUID
* initial_margin          : 6221.02
* last_equity             : 11114.64
* last_maintenance_margin : 2095.23
* long_market_value       : 7002.04
* maintenance_margin      : 2100.612
* multiplier              : 2
* pattern_day_trader      : false
* portfolio_value         : 11132.58
* regt_buying_power       : 9823.12
* short_market_value      : 0.0
* shorting_enabled        : true
* sma                     : 0.0
* status                  : ACTIVE
* trade_suspended_by_user : false
* trading_blocked         : false
* transfers_blocked       : false
```

## Switching Between PAPER and LIVE Accounts

By default AlpacaAPI assumes you're using a PAPER account and not a LIVE account if you don't explicitly set the `APCA_ENDPOINT` environment variable. If after starting up AlpacaAPI.jl you want to change the account you're using, you can use the `set_parameters` function. It is recommended to load your keys from a file on your system instead of typing them directly into the REPL. This example uses the JSON.jl package to read from a `.secrets` file.

```julia
julia> using JSON

julia> AlpacaInfoLIVE = JSON.parsefile("/path/to/.secrets_LIVE")
Dict{String, Any} with 2 entries:
  "SECRET" => "YOUR-LIVE-SECRET-HERE"
  "KEY"    => "YOUR-LIVE-KEY-HERE"

julia> AlpacaAPI.set_parameters(AlpacaAPI.LIVE, AlpacaInfoLIVE["KEY"], AlpacaInfoLIVE["SECRET"])

julia> AlpacaAPI.parameters
AlpacaAPI.AlpacaParameters(AlpacaAPI.LIVE, "YOUR-LIVE-KEY-HERE", "YOUR-LIVE-SECRET-HERE")

```
