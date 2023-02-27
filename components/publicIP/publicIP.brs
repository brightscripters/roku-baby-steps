function init()

    print "@publicIP"
    
    m.setup             = setup
    m.GetAsync          = GetAsync
    m.HandleUrlEvent    = HandleUrlEvent
    m.xferHandler       = xferHandler
    
    m.port = CreateObject("roMessagePort")
    m.setup()
    m.GetAsync("http://api64.ipify.org?format=json")


    while(true)
        msg = wait(0, m.port)
        ' msgType = type(msg)
        print "@publicIP Event in Task"
        m.HandleUrlEvent(msg, xferHandler, invalid)
        ' m.HandleUrlEvent(msg)

    end while

end function


function Setup()
    print "@roUrlTransfer Setup"
    m.pendingXfers = {}
end function


function GetAsync(url as string)
    newXfer = CreateObject("roUrlTransfer")
    newXfer.SetUrl(url)
    newXfer.SetMessagePort(m.port)
    newXfer.AsyncGetToString()
    requestId = newXfer.GetIdentity().ToStr()
    m.pendingXfers[requestId] = newXfer
end function


function HandleUrlEvent(event as object, fnHandler as object, scene as object)
' function HandleUrlEvent(event as object)
    requestId = event.GetSourceIdentity().ToStr()
    xfer = m.pendingXfers[requestId]
    if xfer <> invalid then
        ' process it
        print "@publicIP Handling event..."
        fnHandler(event, scene)
        m.pendingXfers.Delete(requestId)
    end if
end function


function xferHandler(event as object, scene as object)
    print "@main urlXfer Request handled"
    code = event.getResponseCode()

    if 200 <> Code then
        print "@main xfer failure reason: "; event.getfailureReason()
        ' scene.findNode("myLabel").setfield("text", event.getfailureReason())
        return -1
    end if

    print "@main response: "
    response$ = event.getString()
    print response$
    ip$ = ParseJson(response$).ip
    print "@main My public IP: "; ip$

    ' scene.findNode("myLabel").setfield("text", "IP: " + ip$)

end function