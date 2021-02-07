module AlpacaAPI

using HTTP, JSON, TimesDates

@enum EndPoints PAPER=1 LIVE=2

mutable struct AlpacaParameters
    endpoint::EndPoints
    APCA_API_KEY_ID::String
    APCA_API_SECRET_KEY::String
end

# AlpacaAPI Parameters (default to PAPER account)
const parameters = AlpacaParameters(PAPER, ENV["APCA-API-KEY-ID"], ENV["APCA-API-SECRET-KEY"])

# Header for API calls
HEADER(p::AlpacaParameters=parameters)::Tuple{Pair{String,String}, Pair{String,String}} = ("APCA-API-KEY-ID"=>p.APCA_API_KEY_ID, "APCA-API-SECRET-KEY"=>p.APCA_API_SECRET_KEY)

# Default to PAPER endpoint
ENDPOINT(p::AlpacaParameters=parameters)::String = p.endpoint == LIVE ? "https://api.alpaca.markets" : "https://paper-api.alpaca.markets"

function set_parameters(
    endpoint::EndPoints=PAPER,
    APCA_API_KEY_ID::String=ENV["APCA-API-KEY-ID"],
    APCA_API_SECRET_KEY::String=ENV["APCA-API-SECRET-KEY"]
    )
    parameters.endpoint = endpoint
    parameters.APCA_API_KEY_ID = APCA_API_KEY_ID
    parameters.APCA_API_SECRET_KEY = APCA_API_SECRET_KEY
    return
end

include("Account.jl")
include("Orders.jl")

end # module
