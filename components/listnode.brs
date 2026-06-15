sub init()
m.label=m.top.findNode("label")
?"priniting the label node"


end sub


sub dataChanged()
    m.label.text = m.top.itemContent.title
    ?m.top.itemContent.title

end sub


sub onFocusChanged()
    if m.top.itemHasFocus = true
        m.label.color = "#000000"
    else
        m.label.color = "#3b4e4c"
    end if

end sub