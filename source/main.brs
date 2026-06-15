
' main.brs - entrypoint for the Roku channel
' This file creates the SceneGraph screen and sets the main scene as defined
' in the XML file (mainscene.xml). Adjust the scene name if your XML uses
' a different component name.

sub Main()
	screen = CreateObject("roSGScreen")
	if screen = invalid then
		print "Error: could not create roSGScreen"
		return
	end if

	


	' Set the scene XML component name here. Ensure it matches your mainscene.xml
	sceneName = "MainScene"  ' change if your scene component has a different name

	port = CreateObject("roMessagePort")
	screen.SetMessagePort(port)

	scene = screen.CreateScene(sceneName)
	if scene = invalid then
		print "Error: could not create scene: " + sceneName
		return
	end if

	apikey = GetApiKey()

	?"apikey "apikey

	m.global = screen.GetGlobalNode()
    m.global.addFields({
        apiKey: apiKey
    })


	screen.Show()

	' Main event loop: handle system and input events
	while true
		msg = wait(0, port)
		if type(msg) = "roSGScreenEvent" then
			if msg.isScreenClosed() then
				exit while
			end if
		else if type(msg) = "roUniversalClientEvent" then
			' handle other universal events if needed
		else
			' handle input events forwarded to the scene
		end if
	end while
end sub

