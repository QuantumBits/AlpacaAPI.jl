@enum OrderStatus open closed all
@enum OrderType market limit stop stop_limit trailing_stop
@enum OrderSide buy sell
@enum OrderTimeInForce day gtc opg cls ioc fok
@enum OrderLifecycle new partially_filled filled done_for_day canceled expired replaced pending_cancel pending_replace accepted pending_new accepted_for_bidding stopped rejected suspended calculated
@enum OrderClass simple bracket oco oto

struct Order
  asset_class::Union{String,Nothing}
  asset_id::Union{UUID,Nothing}
  canceled_at::Union{TimeDateZone,Nothing}
  client_order_id::Union{UUID,Nothing}
  created_at::Union{TimeDateZone,Nothing}
  expired_at::Union{TimeDateZone,Nothing}
  extended_hours::Union{Bool,Nothing}
  failed_at::Union{TimeDateZone,Nothing}
  filled_at::Union{TimeDateZone,Nothing}
  filled_avg_price::Union{Real,Nothing}
  filled_qty::Union{Real,Nothing}
  hwm::Union{Real,Nothing}
  id::Union{UUID,Nothing}
  legs::Union{Vector{Order},Nothing}
  limit_price::Union{Real,Nothing}
  qty::Union{Real,Nothing}
  replaced_at::Union{TimeDateZone,Nothing}
  replaced_by::Union{UUID,Nothing}
  replaces::Union{UUID,Nothing}
  side::Union{OrderSide,Nothing}
  status::Union{OrderLifecycle,Nothing}
  stop_price::Union{Real,Nothing}
  submitted_at::Union{TimeDateZone,Nothing}
  symbol::Union{String,Nothing}
  time_in_force::Union{OrderTimeInForce,Nothing}
  trail_percent::Union{Real,Nothing}
  trail_price::Union{Real,Nothing}
  type::Union{OrderType,Nothing}
  updated_at::Union{TimeDateZone,Nothing}
end
function Order(d::Dict)

    asset_class      = d["asset_class"]      !== nothing ? d["asset_class"]                                   : nothing
    asset_id         = d["asset_id"]         !== nothing ? UUID(d["asset_id"])                                : nothing
    canceled_at      = d["canceled_at"]      !== nothing ? TimeDateZone(d["canceled_at"])                     : nothing
    client_order_id  = d["client_order_id"]  !== nothing ? UUID(d["client_order_id"])                         : nothing
    created_at       = d["created_at"]       !== nothing ? TimeDateZone(d["created_at"])                      : nothing
    expired_at       = d["expired_at"]       !== nothing ? TimeDateZone(d["expired_at"])                      : nothing
    extended_hours   = d["extended_hours"]   !== nothing ? Bool(d["extended_hours"])                          : nothing
    failed_at        = d["failed_at"]        !== nothing ? TimeDateZone(d["failed_at"])                       : nothing
    filled_at        = d["filled_at"]        !== nothing ? TimeDateZone(d["filled_at"])                       : nothing
    filled_avg_price = d["filled_avg_price"] !== nothing ? parse(Float64, d["filled_avg_price"])              : nothing
    filled_qty       = d["filled_qty"]       !== nothing ? parse(Float64, d["filled_qty"])                    : nothing
    hwm              = d["hwm"]              !== nothing ? parse(Float64, d["hwm"])                           : nothing
    id               = d["id"]               !== nothing ? UUID(d["id"])                                      : nothing
    legs             = d["legs"]             !== nothing ? Vector{Order}(d["legs"])                           : nothing
    limit_price      = d["limit_price"]      !== nothing ? parse(Float64, d["limit_price"])                   : nothing
    qty              = d["qty"]              !== nothing ? parse(Float64, d["qty"])                           : nothing
    replaced_at      = d["replaced_at"]      !== nothing ? TimeDateZone(d["replaced_at"])                     : nothing
    replaced_by      = d["replaced_by"]      !== nothing ? UUID(d["replaced_by"])                             : nothing
    replaces         = d["replaces"]         !== nothing ? UUID(d["replaces"])                                : nothing
    side             = d["side"]             !== nothing ? getproperty(AlpacaAPI, Symbol(d["side"]))          : nothing
    status           = d["status"]           !== nothing ? getproperty(AlpacaAPI, Symbol(d["status"]))        : nothing
    stop_price       = d["stop_price"]       !== nothing ? parse(Float64, d["stop_price"])                    : nothing
    submitted_at     = d["submitted_at"]     !== nothing ? TimeDateZone(d["submitted_at"])                    : nothing
    symbol           = d["symbol"]           !== nothing ? d["symbol"]                                        : nothing
    time_in_force    = d["time_in_force"]    !== nothing ? getproperty(AlpacaAPI, Symbol(d["time_in_force"])) : nothing
    trail_percent    = d["trail_percent"]    !== nothing ? parse(Float64, d["trail_percent"])                 : nothing
    trail_price      = d["trail_price"]      !== nothing ? parse(Float64, d["trail_price"])                   : nothing
    type             = d["type"]             !== nothing ? getproperty(AlpacaAPI, Symbol(d["type"]))          : nothing
    updated_at       = d["updated_at"]       !== nothing ? TimeDateZone(d["updated_at"])                      : nothing

    return Order(
        asset_class      ,
        asset_id         ,
        canceled_at      ,
        client_order_id  ,
        created_at       ,
        expired_at       ,
        extended_hours   ,
        failed_at        ,
        filled_at        ,
        filled_avg_price ,
        filled_qty       ,
        hwm              ,
        id               ,
        legs             ,
        limit_price      ,
        qty              ,
        replaced_at      ,
        replaced_by      ,
        replaces         ,
        side             ,
        status           ,
        stop_price       ,
        submitted_at     ,
        symbol           ,
        time_in_force    ,
        trail_percent    ,
        trail_price      ,
        type             ,
        updated_at       ,
        )
end

"""
    AlpacaAPI.get_orders(endpoint::EndPoints=PAPER)

(Filtered) list all orders for account.

See https://alpaca.markets/docs/api-documentation/api-v2/orders/

"""
function get_orders(
    status::Union{Nothing,OrderStatus}       = nothing, # Order status to be queried. open, closed or all. Defaults to open.
    limit::Union{Nothing,Int}           = nothing, # The maximum number of orders in response. Defaults to 50 and max is 500.
    after::Union{Nothing,TimeDateZone}  = nothing, # The response will include only ones submitted after this timestamp (exclusive.)
    until::Union{Nothing,TimeDateZone}  = nothing, # The response will include only ones submitted until this timestamp (exclusive.)
    direction::Union{Nothing,String}    = nothing, # The chronological order of response based on the submission time. asc or desc. Defaults to desc.
    nested::Union{Nothing,Bool}         = nothing, # If true, the result will roll up multi-leg orders under the legs field of primary order.
    symbols::Union{Nothing,String}      = nothing, # A comma-separated list of symbols to filter by (ex. “AAPL,TSLA,MSFT”).
    )

    query = Dict{String,String}()

    if (status       !== nothing) query["status"]     =  status     end
    if (limit        !== nothing) query["limit"]      =  limit      end
    if (after        !== nothing) query["after"]      =  after      end
    if (until        !== nothing) query["until"]      =  until      end
    if (direction    !== nothing) query["direction"]  =  direction  end
    if (nested       !== nothing) query["nested"]     =  nested     end
    if (symbols      !== nothing) query["symbols"]    =  symbols    end

    r = HTTP.get(join([ENDPOINT(), "v2","orders"],'/'), HEADER(); query = query)

    return Order.(JSON.parse(String(r.body)))

end

"""
    AlpacaAPI.post_orders(endpoint::EndPoints=PAPER)

(Filtered) list all orders for account.

See https://alpaca.markets/docs/api-documentation/api-v2/orders/

"""
function post_orders(
    symbol::String,
    qty::Int,
    side::OrderSide,
    type::OrderType,
    time_in_force::OrderTimeInForce,
    limit_price::Union{Real,Nothing}=nothing,   # Required if type is limit or stop_limit
    stop_price::Union{Real,Nothing}=nothing,    # Required if type is stop or stop_limit
    trail_price::Union{Real,Nothing}=nothing,   # Required if type is trailing_stop and trail_percent is nothing
    trail_percent::Union{Real,Nothing}=nothing, # Required if type is trailing_stop and trail_price is nothing
    extended_hours::Bool=false,
    client_order_id::Union{UUID,Nothing}=nothing,
    order_class::Union{OrderClass,Nothing}=nothing,

    )

    body = Dict{String,String}(
        "symbol"=> string(symbol),
        "qty"   => string(qty),
        "side"  => string(side),
        "type"  => string(type),
    )

    if (status       !== nothing) query["status"]     =  status     end
    if (limit        !== nothing) query["limit"]      =  limit      end
    if (after        !== nothing) query["after"]      =  after      end
    if (until        !== nothing) query["until"]      =  until      end
    if (direction    !== nothing) query["direction"]  =  direction  end
    if (nested       !== nothing) query["nested"]     =  nested     end
    if (symbols      !== nothing) query["symbols"]    =  symbols    end

    r = HTTP.post(join([ENDPOINT(), "v2","orders"],'/'), HEADER(); body = body)

    return JSON.parse(String(r.body))

end