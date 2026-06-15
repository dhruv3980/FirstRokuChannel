sub init()
  ?"called init in the row item component ok if you need anything told me"

  m.poster = m.top.findNode("poster")



end sub

sub showcontent()

  print "show content called in row item" m.top.itemcontent.thumbnail

  itemcontent = m.top.itemContent
  m.poster.width = m.top.width
  m.poster.height = m.top.height
  ? m.top.width.toStr()
  m.poster.uri = "https://dn05fwz6biu1m.cloudfront.net/" + m.top.width.toStr() + "x" + m.top.height.toStr() + "/filters:format(webp):quality(60)/" + itemcontent.thumbnail.Replace(" ", "%20")
  ? "poster uri is " + m.poster.uri

end sub