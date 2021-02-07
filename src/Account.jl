@enum AccountStatus ONBOARDING SUBMISSION_FAILED SUBMITTED ACCOUNT_UPDATED APPROVAL_PENDING ACTIVE REJECTED

struct Account
    account_blocked::Bool
    account_number::String
    buying_power::Real
    cash::Real
    created_at::TimeDateZone
    currency::Currency
    daytrade_count::Int
    daytrading_buying_power::Real
    equity::Real
    id::UUID
    initial_margin::Real
    last_equity::Real
    last_maintenance_margin::Real
    long_market_value::Real
    maintenance_margin::Real
    multiplier::Int
    pattern_day_trader::Bool
    portfolio_value::Real
    regt_buying_power::Real
    short_market_value::Real
    shorting_enabled::Bool
    sma::Real
    status::AccountStatus
    trade_suspended_by_user::Bool
    trading_blocked::Bool
    transfers_blocked::Bool
end
function Base.show(io::IO, ::MIME"text/plain", a::Account)
    print(io, "Account\n-------\n")
    for fname in fieldnames(Account)
        field_value = getfield(a, Symbol(fname))
        if field_value !== nothing
            @printf(io, "* %-23.23s : %s\n", fname, getfield(a, Symbol(fname)))
        end
    end
end
function Account(d::Dict)

    return Account(
        d["account_blocked"],
        d["account_number"],
        parse(Float64, d["buying_power"]),
        parse(Float64, d["cash"]),
        TimeDateZone(d["created_at"]),
        getproperty(AlpacaAPI, Symbol(d["currency"])),
        d["daytrade_count"],
        parse(Float64, d["daytrading_buying_power"]),
        parse(Float64, d["equity"]),
        UUID(d["id"]),
        parse(Float64, d["initial_margin"]),
        parse(Float64, d["last_equity"]),
        parse(Float64, d["last_maintenance_margin"]),
        parse(Float64, d["long_market_value"]),
        parse(Float64, d["maintenance_margin"]),
        parse(Int64, d["multiplier"]),
        d["pattern_day_trader"],
        parse(Float64, d["portfolio_value"]),
        parse(Float64, d["regt_buying_power"]),
        parse(Float64, d["short_market_value"]),
        d["shorting_enabled"],
        parse(Float64, d["sma"]),
        getproperty(AlpacaAPI, Symbol(d["status"])),
        d["trade_suspended_by_user"],
        d["trading_blocked"],
        d["transfers_blocked"],
    )
end

"""
    AlpacaAPI.get_account()

List account information.

See https://alpaca.markets/docs/api-documentation/api-v2/account/

"""
function get_account()

    r = HTTP.get(join([ENDPOINT(), "v2","account"],'/'), HEADER())

    return Account(JSON.parse(String(r.body)))

end