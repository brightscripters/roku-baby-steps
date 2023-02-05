'*************************************************************
'** Roku Baby Steps
' A journey into the Roku eco-system
'*************************************************************

sub Main()
    print "@main "; line_num
    'Indicate this is a Roku SceneGraph application'
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    'Create a scene and load /components/rokuBabySteps.xml'
    scene = screen.CreateScene("rokuBabySteps")
    screen.show()

    setup()
    ' GetAsync("https://api.weather.gov/")
    GetAsync("http://api64.ipify.org?format=json")

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)

        HandleUrlEvent(msg, xferHandler, scene)

        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub


function xferHandler(event as object, scene as object)
    print "@main urlXfer Request handled"
    code = event.getResponseCode()

    if 200 <> Code then
        print "@main xfer failure reason: "; event.getfailureReason()
        scene.findNode("myLabel").setfield("text", event.getfailureReason())
        return -1
    end if

    print "@main response: "
    response$ = event.getString()
    print response$
    ip$ = ParseJson(response$).ip
    print "@main My public IP: "; ip$

    scene.findNode("myLabel").setfield("text", "IP: " + ip$)

end function

