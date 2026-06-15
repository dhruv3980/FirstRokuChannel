sub init()

    m.top.functionName = "getData"
    

end sub


sub getData()
    screenId = m.top.screenId
    ?"screen id in home node: " screenId
    uri = "https://sy0kkefcz0.execute-api.us-east-1.amazonaws.com/enveu_prod/v2/screen?screenId=" + screenId + "&locale=en-US"
    print "uri: " uri   
    apiKey = m.global.apikey

    request = CreateObject("roUrlTransfer")
    request.SetUrl(uri)
    request.AddHeader("x-api-key", apiKey)

    request.AddHeader("accept", "application/json, text/javascript, */*; q=0.01")
    request.AddHeader("accept-language", "en-US,en;q=0.9")
    request.AddHeader("content-type", "application/json")
    request.AddHeader("origin", "https://www.tesliya.com")
    request.AddHeader("referer", "https://www.tesliya.com/")
    request.AddHeader("user-agent", "Mozilla/5.0")
    request.AddHeader("x-app-version", "null")
    request.AddHeader("x-device", "desktop")
    request.AddHeader("x-device-identifier", "null")
    request.AddHeader("x-device-name", "null")
    request.AddHeader("x-device-platform", "null")
    request.AddHeader("x-device-type", "null")
    request.AddHeader("x-platform", "web")
    request.AddHeader("x-tracking-sdk-version", "null")
    print "request headers: " request
    response = request.GetToString()
   
    json = ParseJson(response)
 
    m.top.responseData = json.data
end sub