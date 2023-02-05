function Setup()
    m.pendingXfers = {}
    print "@roUrlTransfer Setup"
end function

function GetAsync(url as string)
    newXfer = CreateObject("roUrlTransfer")
    newXfer.SetUrl(url)
    newXfer.SetMessagePort(m.port)
    newXfer.AsyncGetToString()
    requestId = newXfer.GetIdentity().ToStr()
    m.pendingXfers[requestId] = newXfer
end function

function HandleUrlEvent(event as object, fnHandler as object)
    requestId = event.GetSourceIdentity().ToStr()
    xfer = m.pendingXfers[requestId]
    if xfer <> invalid then
        ' process it
        fnHandler(event)
        m.pendingXfers.Delete(requestId)
    end if
end function