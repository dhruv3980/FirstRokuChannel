sub init()
    m.top.functionName = "getPlaylistData"
end sub

function getPlaylistData()


    sku = m.top.sku
    token = m.top.token
    ?"printing the token in the playertask node"token
    ?"sku prinitng=>in the player"sku
    uri = "https://frontend-api-us1.enveu.io/media-centre/fe/api/v5_0/mediaContent/getPlayableId?sku=" + sku
    if token<>invalid
        uri=uri+"&token="+token
    end if

   apiKey = m.global.apikey

    request = CreateObject("roUrlTransfer")

    request.SetUrl(uri)

    request.AddHeader("accept", "application/json, text/javascript, */*; q=0.01")
    request.AddHeader("accept-language", "en-US,en;q=0.9")
    request.AddHeader("content-type", "application/json")
    request.AddHeader("origin", "https://www.tesliya.com")
    request.AddHeader("referer", "https://www.tesliya.com/")
    request.AddHeader("x-api-key", apiKey)
    request.AddHeader("user-agent", "Mozilla/5.0")
    request.AddHeader("x-app-version", "null")
    request.AddHeader("x-device", "desktop")
    request.AddHeader("x-device-identifier", "null")
    request.AddHeader("x-device-name", "null")
    request.AddHeader("x-device-platform", "null")
    request.AddHeader("x-device-type", "null")
    request.AddHeader("x-platform", "web")
    request.AddHeader("x-tracking-sdk-version", "null")
    request.AddHeader("x-auth", "eyJhbGciOiJIUzUxMiJ9.eyJpZCI6NDc1LCJleHBpcnlUaW1lIjoxODEyNDQyOTQ4OTEwLCJlbWFpbCI6InNjaWFwcHRlc3QyQHlvcG1haWwuY29tIiwicGhvbmVOdW1iZXIiOm51bGwsImFjY291bnRJZCI6ImVlNTk0Mzg3LTY1MzUtNGY1NC1iMzRiLWUwZjUzZGRlNWMwOSIsIm5hbWUiOiIiLCJ1c2VyTmFtZSI6bnVsbCwiZm1DdXN0b21lckFjY291bnRObyI6bnVsbCwiYWNjb3VudFR5cGUiOiJCUkFORCIsIm9yZ2FuaXphdGlvbklkIjoiNjMiLCJ2ZXJpZmllZCI6bnVsbH0.vGYEEGYNVxFRd0hWzoEgKZ6xbT4c0RGwFU02dbJ541liEMiuLIst3FkSDGI8mfZ_WUxZPsWZ5k67SO5c6dPnwg")

    print "FINAL URL = GET playerdataa ===>  " uri


    response = request.GetToString()



    json = ParseJson(response)




    ?"printinhgghggghghghjjjjjjjjjjjjjdbhwebjhh the json data" json



    if response <> invalid


        m.top.responseData = json


    end if

end function