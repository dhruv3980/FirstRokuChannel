sub init()
    m.top.functionName = "getPlaylistData"
end sub

function getPlaylistData()
print "==================================="
    print "TASK FUNCTION ENTERED"
    print "PLAYLIST ID = "; m.top.enveuPlaylistId
    print "==================================="

    playlistId = m.top.enveuPlaylistId

    uri = "https://frontend-api-us1.enveu.tv/media-centre/fe/api/v5_0/mediaPlaylist/contents?playlistId=" + playlistId + "&page=0&size=20&locale=en-US"

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

    print "FINAL URL = "; uri

   
    response = request.GetToString()

    

json = ParseJson(response)




    ?"printinh the json data" 
    for  each data in json.data
        ?data;
    end for
  

    if response <> invalid
        
      
        m.top.responseData = json

      
    end if

end function