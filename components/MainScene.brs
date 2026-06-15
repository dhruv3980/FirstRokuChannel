sub init()
    m.nameLabel = m.top.findNode("nameLabel")
    m.emailLabel = m.top.findNode("emailLabel")
    m.phoneLabel = m.top.findNode("phoneLabel")
    m.privacy = m.top.findNode("privacy")
    m.help = m.top.findNode("help")
    m.privacyTitle = m.top.findNode("privacyTitle")
    m.helpUrl = m.top.findNode("helpUrl")
    m.profile = m.top.findNode("profile")
    m.descriptionbox = m.top.findNode("descriptionbox")
    m.listBackground2 = m.top.findNode("listBackground2")
    m.listbackground1 = m.top.findNode("listbackground1")
    m.wholeScene = m.top.findNode("wholeScene")
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.videoPlayer1 = m.top.findNode("videoPlayer1")
    m.title = m.top.findNode("title")
    m.sidebar = m.top.findNode("sidebar")
    m.listMenu = m.top.findNode("listMenu")
    m.groupId = m.top.findNode("groupid")
    m.sidelistgroup = m.top.findNode("sidelistgroup")
    m.background = m.top.findNode("background")
    m.mainpostertext = m.top.findNode("watchButton")
    m.mainpostergroup = m.top.findNode("mainpostergroup")
    m.sideposter2 = m.top.findNode("sideposter2")
    m.sideposter2.blendColor = "#2d2d2d"
    m.sideposter3 = m.top.findNode("sideposter3")
    m.sideposter3.blendColor = "#2d2d2d"
    m.listBackground = m.top.findNode("listBackground")
    m.listMenu.observeField("itemSelected", "onListItemSelected")
    m.mainpostertext.observeField("buttonSelected", "onWatchButtonSelected")
    m.livePremium=0




    m.requestId = 0
    m.layoutid = m.top.findNode("layout")
    m.sidetext = m.top.findNode("sidetext")
    m.sideposter = m.top.findNode("sideposter")
    m.sidedescription = m.top.findNode("sidedescription")

    m.apiTask = m.top.findNode("TaskNode")
    m.homeNode = m.top.findNode("homeNode")
    m.livelistTaskNode = m.top.findNode("livelistTaskNode")

    m.playlistTask = m.top.findNode("playlistTaskNode")

    m.playerTaskNode = m.top.findNode("playerTaskNode")
    m.playerTaskSecondNode = m.top.findNode("playerTaskSecondNode")

  
    m.checkentitlement = m.top.findNode("checkentitlement")
    m.checkesecondentitlement = m.top.findNode("checkesecondentitlement")
    m.checkesecondentitlement.observeField("responseData", "onsecondentitlementloaded")
   
  
    m.checkentitlement.observeField("responseData", "onentitlementloaded")

    m.playerTaskNode.observeField("responseData", "onPlayerDataLoaded")
    m.playerTaskSecondNode.observeField("responseData", "onPlayerSecondDataLoaded")
   

    m.homeRowList = m.top.findNode("homeRowList")
    m.mainPoster = m.top.findNode("mainPoster")

    m.isFirstLoad = true
    m.isLiveContent = false

    ' OBSERVERS
    m.apiTask.observeField("responseData", "onDataLoaded")
    m.homeNode.observeField("responseData", "onHomeDataLoaded")

    m.playlistTask.observeField("responseData", "onPlaylistLoaded")
    m.livelistTaskNode.observeField("responseData", "onLiveDataLoaded")

    m.sidebar.observeField("itemSelected", "onMenuItemSelected")


    ' INITIAL CONTENT
    m.rowContent = CreateObject("roSGNode", "ContentNode")
    m.homeRowList.content = m.rowContent
    'm.videoPlayer.observeField("state", "onVideoStateChanged")

    ' START MENU API
    m.apiTask.control = "RUN"

    m.homeRowList.observeField("rowItemFocused", "onItemFocused")
    m.homeRowList.observeField("rowItemSelected", "onRowItemSelected")
    onListItem()


end sub


sub onsecondentitlementloaded()
     m.playerTaskSecondNode.control = "STOP"
        
        ?"prinitng the checkentitlement response data" m.checkesecondentitlement.responseData.sku, m.checkesecondentitlement.responseData.accessToken

        m.playerTaskSecondNode.sku = m.checkesecondentitlement.responseData.sku
        m.playerTaskSecondNode.token=m.checkesecondentitlement.responseData.accessToken

         m.playerTaskSecondNode.control = "RUN"



end sub






sub onentitlementloaded()
    ?"printint the response for the entitlement" m.checkentitlement.responseDataf
       m.playerTaskNode.control = "STOP"

        m.playerTaskNode.sku = m.selectedsku
        m.playerTaskNode.token=m.checkentitlement.responseData

         m.playerTaskNode.control = "RUN"




end sub

sub onPlayerSecondDataLoaded()
    m.data2 = m.playerTaskSecondNode.responseData


   
    ? "printing the external ref id====>>>>>>" m.data2.data.externalRefId
    ? "printing the token=======>" m.data2.data.token
    content = CreateObject("roSGNode", "contentNode")
    content.url=m.data2.data.externalUrl  

    m.wholeScene.visible=false
    m.videoPlayer.visible=true
    m.videoPlayer.content=content
    m.videoPlayer.control="play"
    m.videoPlayer.setFocus(true)

end sub

sub onPlayerDataLoaded()
    m.data1 = m.playerTaskNode.responseData

    ? "printing the external ref id====>>>>>>" m.data1.data.externalRefId
    ? "printing the token=======>" m.data1.data.token
    content = CreateObject("roSGNode", "contentNode")
    content.url="https://stream.mux.com/"+m.data1.data.externalRefId+".m3u8"+"?token="+m.data1.data.token

    ?"content url printing" content.url


    m.wholeScene.visible=false
    m.videoPlayer1.visible=true
    m.videoPlayer1.content=content
    m.videoPlayer1.control="play"
    m.videoPlayer1.setFocus(true)

    '   'https://stream.mux.com/' +
    '             externalRefId +
    '             '.m3u8' +
    '             '?token=' +
    '             token;


end sub



sub onRowItemSelected()
    itemnode = m.homeRowList.rowItemSelected
    rowidx = itemnode[0]
    itemidx = itemnode[1]
    rowitem = m.homeRowList.content.getChild(rowidx).getChild(itemidx)
    m.selectedsku=rowitem.sku

    ?"row item printing" rowitem
    if rowitem.premium="1"
        ?"printing the entitlement" rowitem
        m.checkentitlement.control="STOP"
        m.checkentitlement.sku=rowitem.sku
        m.checkentitlement.control="RUN"




    else if rowitem.premium="0"


    if rowItem.sku <> invalid

         m.playerTaskNode.control = "STOP"

        m.playerTaskNode.sku = rowItem.sku

         m.playerTaskNode.control = "RUN"

    end if

end if

    ' m.wholeScene.visible=false
    ' m.videoPlayer1.visible=true
    ' m.videoPlayer1.content=content
    ' m.videoPlayer1.control="play"
    ' m.videoPlayer1.setFocus(true)


end sub

' sub onVideoStateChanged()

'     ?"STATE = "; m.videoPlayer.state

'     if m.videoPlayer.state = "paused"
'         m.videoPlayer.control = "resume"
'     end if

' end sub


sub onWatchButtonSelected()

    ? "CLICKED LIVE SKU = "; m.liveSku
    ? "CLICKED LIVE PREMIUM = "; m.livePremium
    if m.livePremium=true


     m.selectedsku = m.liveSku

        m.checkesecondentitlement.control = "STOP"
        m.checkesecondentitlement.sku = m.liveSku
        m.checkesecondentitlement.control = "RUN"

    else

        m.playerSecondTaskNode.control = "STOP"
        m.playerSecondTaskNode.sku = m.liveSku
        m.playerSecondTaskNode.control = "RUN"

    end if
    ' content = createObject("roSGNode", "ContentNode")
    ' content.url = "https://content.jwplatform.com/manifests/2wWf8wJ3.m3u8"

    ' m.wholeScene.visible = false
    ' m.videoPlayer.visible = true
    ' m.videoPlayer.content = content
    ' m.videoPlayer.control = "play"
    ' m.videoPlayer.setFocus(true)

end sub









sub onListItem()
    contentNode = createObject("roSGNode", "ContentNode")

    items = [
        {
            "title": "Profile",
            "description": "Manage your profile and preferences",
            "Name": "Dhruv Sahu",
            "Email": "Dhruv.sahu@enveu.com",
            "Phone": "8126999999"

        },
        {
            "title": "Privacy",
            "description": "Manage your privacy settings, control how your personal information is used, and choose what data is shared with others."
        },

        {
            "title": "Help",
            "description": "Get help with your account, billing, technical issues, and more. Our support team is here to assist you with any questions or concerns you may have."
        }



    ]

    for each item in items
        itemNode = contentNode.createChild("CustomContentNode")
        itemNode.title = item.title
        itemNode.description = item.description

        if item.name <> invalid
            itemNode.Name = "Name: " + item.Name
        end if
        if item.Email <> invalid
            itemNode.Email = "Email: " + item.Email
        end if
        if item.Phone <> invalid
            itemNode.Phone = "Phone: " + item.Phone
        end if

    end for
    m.listMenu.content = contentNode



end sub
sub onListItemSelected()

    index = m.listMenu.itemSelected
    if index = 0
        item = m.listMenu.content.getChild(0)
        m.privacy.visible = false

        m.help.visible = false
        m.profile.visible = true
        m.nameLabel.text = item.Name
        m.emailLabel.text = item.Email
        m.phoneLabel.text = item.Phone


    else if index = 1
        item = m.listMenu.content.getChild(1)

        m.profile.visible = false
        m.privacy.visible = true
        m.help.visible = false

        m.privacyTitle.text = item.description

    else if index = 2
        item = m.listMenu.content.getChild(2)

        m.profile.visible = false
        m.privacy.visible = false
        m.help.visible = true

        m.helpUrl.text = item.description

    end if

end sub

sub onItemFocused()

    focused = m.homeRowList.rowItemFocused
    if focused = invalid then return

    rowIndex = focused[0]
    itemIndex = focused[1]

    rowNode = m.homeRowList.content.getChild(rowIndex)

    if rowNode = invalid then return

    itemNode = rowNode.getChild(itemIndex)

    if itemNode = invalid then return
    ?"printing the description for an itemnode" itemNode.description
    m.sidedescription.text = itemNode.description

    m.sidetext.text = itemNode.title
    ?"printing the itemuri for the top poster banner" "https://dn05fwz6biu1m.cloudfront.net/800x281/filters:format(webp):quality(60)/" + itemNode.thumbnail
    m.sideposter.uri = "https://dn05fwz6biu1m.cloudfront.net/800x562/filters:format(webp):quality(60)/" + itemNode.thumbnail





end sub



sub onDataLoaded()

    response = m.apiTask.responseData

    if response = invalid then
        return
    end if

    contentNode = CreateObject("roSGNode", "ContentNode")

    for each item in response.orderedMenuItems

        row = CreateObject("roSGNode", "CustomContentNode")

        row.title = item.menuItem.displayName
        row.image = item.menuItem.icon
        row.id = item.menuItem.screenId
        row.menuType = item.menuItem.displayName

        contentNode.appendChild(row)

    end for
    row = CreateObject("roSGNode", "CustomContentNode")
    row.title = "Settings"
    row.image = "pkg:/images/setting.jpg"
    row.id = "123"
    row.menuType = "Settings"
    contentNode.appendChild(row)

    m.sidebar.content = contentNode

    firstItem = contentNode.getChild(0)
    if firstItem <> invalid
        m.selectedMenuItemIndex = 0

        m.homeNode.screenId = firstItem.id
        m.homeNode.control = "RUN"
        m.isLiveContent = true


    end if
    m.title.visible = false

    m.sidebar.setFocus(true)

end sub



function onMenuItemSelected()

    index = m.sidebar.itemSelected
    print "====================================="
    print "MENU SELECTED = "; index
    print "====================================="
    m.selectedMenuItemIndex = index

    if index < 0 then
        return false
    end if
    if index = 2
        m.homeNode.control = "STOP"
        m.playlistTask.control = "STOP"
        m.livelistTaskNode.control = "STOP"
        m.widgetData = invalid
        m.widgetCount = 0
        m.layoutid.visible = false
        m.mainpostertext.visible = false
        m.currentWidgetIndex = 0
        m.listBackground.translation = [410, 260]
        m.listbackground1.translation = [409, 259]

        m.listBackground.visible = true
        m.listbackground1.visible = true
        m.listMenu.jumpToItem = 0
        m.listMenu.setFocus(true)
        profileNode = m.listMenu.content.getChild(0)


        m.descriptionbox.visible = true
        m.listBackground2.visible = true
        m.profile.visible = true
        m.privacy.visible = false
        m.help.visible = false
        if profileNode <> invalid
            m.nameLabel.text = profileNode.Name
            m.emailLabel.text = profileNode.Email
            m.phoneLabel.text = profileNode.Phone
        end if





        m.homeRowList.visible = false
        m.sideposter.visible = false
        m.sideposter2.visible = false
        m.sideposter3.visible = false
        m.mainPoster.visible = false
        return true


    end if

    m.listBackground.visible = false
    m.listbackground1.visible = false



    m.descriptionbox.visible = false
    m.listBackground2.visible = false


    if index = 0
        m.sidetext.text = ""
        m.sideposter.uri = ""
        m.layoutid.visible = false
        m.isLiveContent = true
        m.mainPoster.width = 1850

        m.sideposter.visible = false
        m.sideposter2.visible = false
        m.sideposter3.visible = false


        m.mainPoster.visible = true
        m.homeRowList.visible = false
        m.mainpostertext.visible = true

    else

        m.isLiveContent = false

        m.mainPoster.visible = false
        m.homeRowList.visible = true
        m.mainpostertext.visible = false

    end if
    m.homeNode.control = "STOP"
    m.playlistTask.control = "STOP"
    m.livelistTaskNode.control = "STOP"
    m.currentWidgetIndex = 0
    m.widgetCount = 0
    m.widgetData = invalid


    m.homeRowList.content = invalid

    m.mainPoster.uri = ""

    ' STOP TASKS
    m.playlistTask.control = "STOP"
    m.livelistTaskNode.control = "STOP"


    m.rowContent = CreateObject("roSGNode", "ContentNode")
    m.homeRowList.content = m.rowContent

    m.currentWidgetIndex = 0
    m.isFirstLoad = true

    menuItem = m.sidebar.content.getChild(index)

    if menuItem <> invalid

        screenId = menuItem.id

        m.homeNode.screenId = screenId
        m.homeNode.control = "RUN"

    end if

    return true

end function


sub onHomeDataLoaded()

    print "====================================="
    print "ON HOME DATA LOADED"
    print "====================================="

    response = m.homeNode.responseData

    print "HOME RESPONSE"
    print response.widgets[0]


    if response = invalid or response.widgets = invalid then

        print "Home response invalid"

        return

    end if


    if response <> invalid and response.widgets <> invalid then
        print "TOTAL WIDGETS = "; response.widgets.count()
    end if

    if m.isLiveContent

        print "LIVE TV FLOW"

        if response.widgets.count() > 0

            widget = response.widgets[0]

            if widget <> invalid and widget.item <> invalid and widget.item.playlist <> invalid

                playlistId = widget.item.playlist.enveuPlaylistId

                if playlistId <> invalid

                    print "Calling LiveListTaskNode"

                    m.livelistTaskNode.control = "STOP"

                    m.livelistTaskNode.enveuPlaylistId = playlistId.toStr()

                    m.livelistTaskNode.control = "RUN"

                end if

            end if

        end if

    else



        m.widgetData = response.widgets
        m.widgetCount = response.widgets.count()

        m.currentWidgetIndex = 0

        loadNextPlaylist()

    end if

end sub



sub loadNextPlaylist()
    print "WIDGET NAME = "; m.widgetData[m.currentWidgetIndex].name

    print "-------------------------------------"
    print "LOAD NEXT PLAYLIST"
    print "CURRENT INDEX = "; m.currentWidgetIndex
    print "WIDGET COUNT = "; m.widgetCount
    print "-------------------------------------"

    if m.currentWidgetIndex >= m.widgetCount




        return

    end if

    widget = m.widgetData[m.currentWidgetIndex]


    if widget = invalid or widget.item = invalid or widget.item.playlist = invalid

        m.currentWidgetIndex = m.currentWidgetIndex + 1


        loadNextPlaylist()

        return

    end if

    playlistId = widget.item.playlist.enveuPlaylistId

    if playlistId = invalid then

        m.currentWidgetIndex = m.currentWidgetIndex + 1

        loadNextPlaylist()

        return

    end if

    print "Calling PlaylistTaskNode"
    playlistId = widget.item.playlist.enveuPlaylistId




    m.playlistTask.unobserveField("responseData")


    m.playlistTask = CreateObject("roSGNode", "PlaylistTaskNode")

    ' Observe callback again
    m.playlistTask.observeField("responseData", "onPlaylistLoaded")

    ' Set data
    m.playlistTask.enveuPlaylistId = playlistId.toStr()

    ' Run
    m.playlistTask.control = "RUN"

end sub


sub onLiveDataLoaded()



    response = m.livelistTaskNode.responseData

    if response = invalid then

        print "Live response invalid"

        return

    end if


    if response.data <> invalid and response.data.items <> invalid

        if response.data.items.count() > 0

            firstItem = response.data.items[0]

            if firstItem.content <> invalid

                content = firstItem.content
                m.liveSku = content.sku
                m.livePremium = content.premium
                m.liveContentId = content.id

                print "LIVE CONTENT"
                print content


                if content.images <> invalid and content.images.count() > 0

                    image = content.images[0]

                    if image.imageContent <> invalid

                        url = image.imageContent.src

                        url = url.Replace(" ", "%20")




                        m.mainPoster.uri = url
                        m.mainPoster.visible = true

                        m.mainpostertext.setFocus(true)




                        m.background.width = 100
                        m.mainPoster.translation = [100, 0]
                        m.sidebar.itemSize = [70, 60]
                        m.mainPoster.width = 1850

                        m.mainpostertext.translation = [200, 800]




                    end if

                end if

            end if

        end if

    end if

end sub



sub onPlaylistLoaded()
    print "================================="
    print "CALLBACK RECEIVED"
    print "INDEX = "; m.currentWidgetIndex

    if m.playlistTask.responseData <> invalid and m.playlistTask.responseData.data <> invalid and m.playlistTask.responseData.data.items <> invalid
        print "ITEM COUNT = "; m.playlistTask.responseData.data.items.count()
    end if

    print "================================="
    if m.widgetData = invalid then
        print "WIDGET DATA INVALID"
        return
    end if

    if m.currentWidgetIndex >= m.widgetData.count() then
        print "INDEX OUT OF RANGE"
        return
    end if

    print "PLAYLIST CALLBACK"
    print "CURRENT INDEX = "; m.currentWidgetIndex
    print "MENU INDEX = "; m.selectedMenuItemIndex
    print "#####################################"
    print "ON PLAYLIST LOADED"
    print "CURRENT INDEX = "; m.currentWidgetIndex
    print "#####################################"

    response = m.playlistTask.responseData

    print "PLAYLIST RESPONSE"
    print response

    if response = invalid then
        return
    end if

    if m.rowContent <> invalid then
        print "CURRENT ROW COUNT = "; m.rowContent.getChildCount()
    end if


    if response.data = invalid or response.data.items = invalid

        m.currentWidgetIndex = m.currentWidgetIndex + 1
        print "NEXT INDEX = "; m.currentWidgetIndex

        if m.currentWidgetIndex < m.widgetCount then
            print "NEXT WIDGET = "; m.widgetData[m.currentWidgetIndex].name
        end if

        loadNextPlaylist()

        return

    end if






    widget = invalid

    if m.currentWidgetIndex < m.widgetData.count() then
        widget = m.widgetData[m.currentWidgetIndex]
    else
        print "BAD INDEX = "; m.currentWidgetIndex
        return
    end if

    print "CURRENT WIDGET NAME = "; widget.name

    print "CREATING ROW NODE"
    if response.data.items.count() > 0 then

        rowNode = m.rowContent.createChild("ContentNode")

        print "ROWLIST CONTENT COUNT = "; m.homeRowList.content.getChildCount()

        print "ROW CREATED"
        print "ROW COUNT AFTER CREATE = "; m.rowContent.getChildCount()

        rowNode.title = widget.name

        print "CREATING ROW: "; widget.name




        for each item in response.data.items

            content = item.content

            if content <> invalid

                itemNode = rowNode.createChild("CustomContentNode")

                ' TITLE
                itemNode.title = content.title

                itemNode.description = content.description

                itemNode.sku = content.sku
                itemNode.premium=content.premium
                itemNode.contentid=content.id



                ' IMAGE
                if content.images <> invalid and content.images.count() > 0

                    image = content.images[0]

                    if image.imageContent <> invalid

                        thumbUrl = image.imageContent.src

                        thumbUrl = thumbUrl.Replace(" ", "%20")

                        itemNode.thumbnail = thumbUrl

                        print "THUMB URL: "; thumbUrl

                    end if

                end if

            end if

        end for
    end if

    if m.isFirstLoad and m.rowContent.getChildCount() = 1

        m.isFirstLoad = false

        m.homeRowList.setFocus(true)
        m.groupId.translation = [60, 0]
        m.background.width = 100
        m.sidebar.itemSize = [70, 60]
        m.sideposter.translation = [1055, 0]
        m.sideposter2.translation = [1055, 0]
        m.sideposter3.translation = [1055, 329]



        m.layoutid.visible = true

        m.sideposter.visible = true
        m.sideposter2.visible = true
        m.sideposter3.visible = true

    end if


    ' if m.isFirstLoad = true

    '     print "SETTING INITIAL FOCUS"

    '     m.homeRowList.setFocus(true)

    '     m.isFirstLoad = false

    ' end if












    '     ' REFRESH ONLY FIRST TIME
    ' if m.currentWidgetIndex = 0

    '     m.homeRowList.content = m.rowContent

    ' end if










    '     if m.isFirstLoad = true

    '     print "SETTING INITIAL FOCUS"

    '     m.homeRowList.setFocus(true)

    '     m.isFirstLoad = false

    ' end if




    m.currentWidgetIndex = m.currentWidgetIndex + 1

    print "AFTER INCREMENT = "; m.currentWidgetIndex
    print "TOTAL ROWS = "; m.rowContent.getChildCount()



    ' MORE PLAYLISTS REMAIN
    if m.currentWidgetIndex < m.widgetCount

        loadNextPlaylist()





    else
        print "all playlist loaded"
    end if
end sub


' =========================================================
' KEY EVENTS
' =========================================================
function onKeyEvent(key as string, press as boolean) as boolean

    if not press then return false
    if key = "back"
        if m.videoPlayer.visible = true
            m.videoPlayer.control = "stop"
            m.videoPlayer.visible = "false"
            m.wholeScene.visible = "true"
            m.mainpostertext.setFocus(true)



            return true


        else if m.videoPlayer1.visible = true
            m.videoPlayer1.control = "stop"
            m.videoPlayer1.visible = "false"
            m.wholeScene.visible = "true"

            m.homeRowList.setFocus(true)


            return true

        end if

    end if

    ' ==========================================
    ' RIGHT KEY
    ' ==========================================
    if key = "right"


        if m.sidebar.hasFocus()
            if m.selectedMenuItemIndex = 2
                ?"settings menu focused"
                m.listBackground.visible = true
                m.listbackground1.visible = true

                m.listMenu.setFocus(true)
                return true
            else if m.isLiveContent
                m.mainpostertext.setFocus(true)
                m.background.width = 100
                m.mainPoster.translation = [100, 0]
                m.sidebar.itemSize = [70, 60]
                m.mainPoster.width = 1850
                m.mainpostertext.translation = [200, 800]
                return true
            end if

            if not m.isLiveContent

                if m.homeRowList.content <> invalid and m.homeRowList.content.getChildCount() > 0

                    m.homeRowList.setFocus(true)
                    m.groupId.translation = [60, 0]
                    m.background.width = 100
                    m.sidebar.itemSize = [70, 60]
                    m.sideposter.translation = [1055, 0]

                    m.sideposter2.translation = [1055, 0]
                    m.sideposter3.translation = [1055, 329]




                    return true

                end if

            end if

        end if

    end if


    ' ==========================================
    ' LEFT KEY
    ' ==========================================
    if key = "left"
        if m.listMenu.hasFocus()


            m.sidebar.setFocus(true)

        else if m.mainpostertext.hasFocus()
            m.sidebar.setFocus(true)

            m.mainPoster.translation = [370, 0]
            m.background.width = "370"
            m.sidebar.itemSize = [335, 60]
            m.mainPoster.width = 1750
            m.mainpostertext.translation = [500, 800]
            return true
        end if

        if m.homeRowList.hasFocus()

            focusedItem = m.homeRowList.rowItemFocused
            if focusedItem = invalid then
                return false
            end if

            itemindex = focusedItem[1]

            if itemindex = 0

                m.sidebar.setFocus(true)
                m.groupId.translation = [290, 0]
                m.background.width = "370"
                m.sidebar.itemSize = [335, 60]
                m.sideposter.translation = [825, 0]
                m.sideposter2.translation = [825, 0]
                m.sideposter3.translation = [825, 329]


                return true

            end if

        end if

    end if

    return false

end function