"""
    AlpacaAPI.get_account()

List account information.

See https://alpaca.markets/docs/api-documentation/api-v2/account/

"""
function get_account()

    r = HTTP.get(join([ENDPOINT(), "v2","account"],'/'), HEADER())

    return JSON.parse(String(r.body))

end