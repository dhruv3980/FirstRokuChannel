sub init()

    m.top.functionName = "getData"

end sub


sub getData()
    uri = "https://api-us1.enveu.io/experience-manager-fe-api/app/api/v2/menuManager/getMenuDetails?locale=en-US"
    apiKey = m.global.apikey

    request = CreateObject("roUrlTransfer")
    request.SetUrl(uri)
    request.AddHeader("x-api-key", apiKey)


    response = request.GetToString()
    ?"response priniting" len(response)
    json = ParseJson(response)
    ?"json priniting" json.data
        m.top.responseData = json.data
end sub