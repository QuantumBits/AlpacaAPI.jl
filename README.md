# AlpacaAPI.jl

## The Julia Alpaca API Wrapper

AlpacaAPI.jl is a wrapper built entirely in Julia for [Alpaca, the modern platform for algorithmic trading](https://alpaca.markets/docs/api-documentation/api-v2/).

**Currently a work in progress! As I am merely a single devleoper working in my free time this project might take a little while.**

## Getting Started

To use the Alpaca API, you'll need to first [get your API key after creating an account with Alpaca](https://app.alpaca.markets/).

After that, you'll need to put your API Key ID and your Secret Key and put them into environment variables called `APCA-API-KEY-ID` and `APCA-API-SECRET-KEY`, respectively. By default AlpacaAPI.jl assumes you're using a **PAPER** account, but you can also set the `APCA-API-ENDPOINT` environment variable to "LIVE" or "PAPER" to set the endpoint to **LIVE** or **PAPER**, respectively.

An easy way to set this up is to add the following lines to your `~/.julia/config/startup.jl` script.

```julia
ENV["APCA-API-ENDPOINT"]    = "PAPER"
ENV["APCA-API-KEY-ID"]      = "YOUR-PAPER-KEY-HERE"
ENV["APCA-API-SECRET-KEY"]  = "YOUR-PAPER-SECRET-HERE"
```

> Keep in mind that your **PAPER** and **LIVE** accounts use **different keys!**

After this initial setup, it's easy to start using AlpacaAPI

```julia
julia> using AlpacaAPI

julia> c = AlpacaAPI.credentials()
AlpacaAPI.Credentials(AlpacaAPI.LIVE, "YOUR-LIVE-KEY-HERE", "YOUR-LIVE-SECRET-HERE")

julia> AlpacaAPI.account(c)
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

## API Implementation Status

### Accounts (Done!)

[Link to Accounts Documentation](https://alpaca.markets/docs/api-documentation/api-v2/account/)

### Orders (In Progress)

[Link to Orders Documentation](https://alpaca.markets/docs/api-documentation/api-v2/orders/)

### Positions (Planned)

[Link to Positions Documentation](https://alpaca.markets/docs/api-documentation/api-v2/positions/)

### Assets (Planned)

[Link to Assets Documentation](https://alpaca.markets/docs/api-documentation/api-v2/assets/)

### Streaming (Planned)

[Link to Streaming Documentation](https://alpaca.markets/docs/api-documentation/api-v2/streaming/)

### Watchlist (Planned)

[Link to Watchlist Documentation](https://alpaca.markets/docs/api-documentation/api-v2/watchlist/)

### Calendar (Planned)

[Link to Calendar Documentation](https://alpaca.markets/docs/api-documentation/api-v2/calendar/)

### Clock (Planned)

[Link to Clock Documentation](https://alpaca.markets/docs/api-documentation/api-v2/clock/)

### Account Configurations (Planned)

[Link to Account Configurations Documentation](https://alpaca.markets/docs/api-documentation/api-v2/account-configuration/)

### Account Activities (Planned)

[Link to Account Activities Documentation](https://alpaca.markets/docs/api-documentation/api-v2/account-activities/)

### Portfolio History (Planned)

[Link to Portfolio History Documentation](https://alpaca.markets/docs/api-documentation/api-v2/portfolio-history/)

### Market Data (Planned)

[Link to Market Data Documentation](https://alpaca.markets/docs/api-documentation/api-v2/market-data/)

### Polygon Integration (Planned)

[Link to Polygon Integration Documentation](https://alpaca.markets/docs/api-documentation/api-v2/polygon-integration/)
