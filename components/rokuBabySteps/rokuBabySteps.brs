
function init()
    print "@rokuBabyStemps init()"
    m.top.setFocus(true)
    m.myLabel = m.top.findNode("myLabel")
    ' m.myLabel.observeField("text", "fnObserved")
    'Set the font size
    m.myLabel.font.size = 92

    'Set the color to light blue
    m.myLabel.color = "0x72D7EEFF"
    '**
    '** The full list of editable attributes can be located at:
    '** http://sdkdocs.roku.com/display/sdkdoc/Label#Label-Fields
    '**

    ' m.setup = setup
    ' m.GetAsync = GetAsync

    ' m.setup()
    ' m.GetAsync("http://api64.ipify.org?format=json")
    m.publicIpTask = createObject("roSGNode", "publicIp")

end function


sub setLabelText() ' label$, text$
    m.top.findNode("myLabel").setfield("text", "foo")
end sub


sub fnObserved()
    print "@fnObserved"
    stop
end sub