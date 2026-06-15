sub init()
    print "Initializing sideBarItem"
    m.labeltext = m.top.findNode("label")
    ' m.contentType = m.top.findNode("itemContent")
    m.top.observeField("itemHasFocus", "onFocusChanged")
    m.icon = m.top.findNode("icon")


end sub

function dataChanged()

    print "data changed: " m.top.itemContent
    m.labeltext.text= m.top.itemContent.title
    m.icon.uri = m.top.itemContent.image

end function


sub onFocusChanged()
    ? "fn called" m.top.itemHasFocus
    if m.top.itemHasFocus = true
        m.labeltext.color = "#000000"
    else
        m.labeltext.color = "#3b4e4c"
    end if
end sub