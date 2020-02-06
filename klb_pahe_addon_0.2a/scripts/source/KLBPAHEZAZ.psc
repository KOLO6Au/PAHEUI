Scriptname KLBPAHEZAZ extends Quest  
spell Property KLBpahezazcloaksp Auto
quest Property KLBPAHEExtZAZ Auto
Event OnInit()
    Game.Getplayer().addspell(KLBpahezazcloaksp, false)
    RegisterForSingleUpdate(2.0)
 EndEvent

Event OnUpdate()     
    Game.GetPlayer().removespell(KLBpahezazcloaksp)
    KLBPAHEExtZAZ.Stop()
    
EndEvent