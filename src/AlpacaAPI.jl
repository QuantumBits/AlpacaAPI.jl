module AlpacaAPI

using HTTP, JSON, TimesDates

using  UUIDs, Printf

import Base.show

@enum EndPoint PAPER=1 LIVE=2

mutable struct AlpacaParameters
    ENDPOINT::EndPoint
    APCA_API_KEY_ID::String
    APCA_API_SECRET_KEY::String
end

# AlpacaAPI Parameters (default to PAPER account)
const parameters = AlpacaParameters(
    haskey(ENV, "APCA-ENDPOINT") ? getproperty(AlpacaAPI, Symbol(ENV["APCA-ENDPOINT"])) : PAPER,
    ENV["APCA-API-KEY-ID"], 
    ENV["APCA-API-SECRET-KEY"])

# Header for API calls
HEADER(p::AlpacaParameters=parameters)::Tuple = ("APCA-API-KEY-ID"=>p.APCA_API_KEY_ID, "APCA-API-SECRET-KEY"=>p.APCA_API_SECRET_KEY, "Content-Type"=>"application/json")

# Default to PAPER endpoint
ENDPOINT(p::AlpacaParameters=parameters)::String = p.ENDPOINT == LIVE ? "https://api.alpaca.markets" : "https://paper-api.alpaca.markets"

function set_parameters(
    ENDPOINT::EndPoint=PAPER,
    APCA_API_KEY_ID::String=ENV["APCA-API-KEY-ID"],
    APCA_API_SECRET_KEY::String=ENV["APCA-API-SECRET-KEY"]
    )::AlpacaParameters

    AlpacaAPI.parameters.ENDPOINT = ENDPOINT
    AlpacaAPI.parameters.APCA_API_KEY_ID = APCA_API_KEY_ID
    AlpacaAPI.parameters.APCA_API_SECRET_KEY = APCA_API_SECRET_KEY

    return AlpacaAPI.parameters
end

include("Misc.jl")

include("Account.jl")
include("Orders.jl")

end # module
