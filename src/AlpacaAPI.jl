module AlpacaAPI

using HTTP, JSON, TimesDates
using  UUIDs, Printf
import Base.show

@enum EndPoint PAPER=1 LIVE=2

struct Credentials
    ENDPOINT::EndPoint
    KEY_ID::String
    SECRET_KEY::String
end

# Header for API calls
HEADER(c::Credentials)::Tuple = ("APCA-API-KEY-ID"=>c.KEY_ID, "APCA-API-SECRET-KEY"=>c.SECRET_KEY, "Content-Type"=>"application/json")

# Default to PAPER endpoint
ENDPOINT(c::Credentials)::String = c.ENDPOINT == LIVE ? "https://api.alpaca.markets" : "https://paper-api.alpaca.markets"

"""
    AlpacaAPI.credentials()

    Get Alpaca API credentials from Environment Variables `APCA-API-ENDPOINT`, `APCA-API-KEY-ID`, and `APCA-API-SECRET-KEY`.
"""
credentials() = Credentials(
    getproperty(AlpacaAPI, Symbol(ENV["APCA-API-ENDPOINT"])),
    ENV["APCA-API-KEY-ID"],
    ENV["APCA-API-SECRET-KEY"])


# Miscellaneous Stuff
include("Misc.jl")

# API Endpoints
include("Account.jl")
include("Orders.jl")

end # module
