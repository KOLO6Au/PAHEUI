Scriptname KLBPAHECORE extends Quest  
Import Game
PAHCore Property PAH Auto
actor Property croshref Auto Hidden
PAHSlave property m_slave auto hidden
actor property playerref auto
PahDiag Property PAHDiags Auto 
Faction Property PAHPlayerSlaveFaction Auto
Faction Property PAHBEFollowing Auto
Faction Property PAHBEWaiting Auto
Message Property PAHSlaveInfoMessage Auto
quest Property KLBPAHEExtZAZ Auto
int result
Event OnInit()
     RegisterForKey(38) ;L KEY
  UIExtensions.InitMenu("UIWheelMenu")
  
 
  
  RegisterForModEvent("UIWheelMenu_ChooseOption", "OnChooseOption")
  RegisterForModEvent("UIWheelMenu_LoadMenu", "OnLoadMenu")
  RegisterForModEvent("UIWheelMenu_CloseMenu", "OnUnloadMenu")
  RegisterForModEvent("UIWheelMenu_SetOption", "OnSelectOption")
  
  playerref=Game.GetPlayer()
  
  Debug.Notification("Radial Menu is successfully registered.")
EndEvent


Event OnKeyUp(int keyCode, float holdTime)
    if (!Utility.IsInMenuMode())
    if keyCode == 38
        croshref=GetCurrentCrosshairRef() as Actor
        if croshref.IsInFaction(PAHPlayerSlaveFaction)==1
        UpdateWMenu()
      
     UIExtensions.OpenMenu("UIWheelMenu",croshref)
    endif
   endif
endif
EndEvent

Event OnLoadMenu(string eventName, string strArg, float numArg, Form formArg)
 
EndEvent

Event OnChooseOption(string eventName, string strArg, float numArg, Form formArg)
result = numArg as Int
if  result==0
    if croshref.isinfaction(PAHBEFollowing)
        PAHDiagS.Wait(croshref)
   ElseIf croshref.isinfaction(PAHBEWaiting)
        PAHDiagS.Follow(croshref)
   endif
   
elseif result==1
    if croshref.IsDoingFavor()
    Else
       croshref.SetDoingFavor()
   endif
 elseif result==2
     croshref.OpenInventory(True)
 elseif result==3
      PAHDiagS.OpenBackpack(croshref)
      
  elseif result==4
      if m_slave.should_fight_for_player == False
         PAHDiagS.CommandDoCombat(croshref)
     Else
        PAHDiagS.CommandNoLongerDoCombat(croshref)
          
      endif
elseif result==5
         
   if (!KLBPAHEExtZAZ.IsRunning())
       KLBPAHEExtZAZ.Start()
   endif
          
elseif result==6
     PAHDiagS.Strip(croshref)
 ElseIf result==7
    PAHSlaveInfoMessage.Show(\
    m_slave.submission, \
    m_slave.combat_training, \
    m_slave.anger_training, \
    m_slave.respect_training, \
    m_slave.pose_training, \
    m_slave.sex_training, \
    m_slave.fear_training \
    ) 
    
endif
EndEvent

Event OnSelectOption(string eventName, string strArg, float numArg, Form formArg)

endevent 

Event OnUnloadMenu(string eventName, string strArg, float numArg, Form formArg)
  
EndEvent

Function UpdateWMenu()
     UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionLabelText", 0, "$KLB_OPT1A")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 1, "$KLB_OPTD2")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionLabelText", 1, "$KLB_OPT2")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 2, "$KLB_OPTD3")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionLabelText", 2, "$KLB_OPT3")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 3, "$KLB_OPTD4")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionLabelText", 3, "$KLB_OPT4")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionLabelText", 4, "$KLB_OPT5")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionLabelText", 5, "$KLB_FIXZAZ")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 5, "$KLB_FIXZAZD")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionLabelText", 6, "$KLB_OPT6")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 6, "$KLB_OPTD6")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionLabelText", 7, "$KLB_OPT7")
  UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 7, "$KLB_OPTD7")

  UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu", "optionEnabled", 7,true)
  UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu", "optionEnabled", 6,true)
  
  UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu", "optionEnabled", 4,true)
  UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu", "optionEnabled", 3,true)
  UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu", "optionEnabled", 2,true)
  UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu", "optionEnabled", 1,true)
  UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu", "optionEnabled", 0,true)
  
   m_slave = PAHDiags.GetSlave(croshref)
        if croshref.isinfaction(PAHBEFollowing)
        UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionLabelText", 0, "$KLB_OPT1B")
         UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 0, "$KLB_OPTD1")
     ElseIf croshref.isinfaction(PAHBEWaiting)
        UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionLabelText", 0, "$KLB_OPT1A")
        UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 0, "$KLB_OPTD1Y")
        Else
         UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 0, "$KLB_OPTD1U")
     endif
    
     
      if  m_slave.should_fight_for_player == False
     UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 4, "$KLB_OPTD5N")
     Else
             UIExtensions.SetMenuPropertyIndexString("UIWheelMenu", "optionText", 4, "$KLB_OPTD5Y")
    endif
    
    if KLBPAHEExtZAZ.IsRunning()
        UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu", "optionEnabled", 5,false)
        UIExtensions.SetMenuPropertyIndexInt("UIWheelMenu", "optionTextColor", 5,  0xFF0000)
    Else
        UIExtensions.SetMenuPropertyIndexBool("UIWheelMenu", "optionEnabled", 5,true)
        UIExtensions.SetMenuPropertyIndexInt("UIWheelMenu", "optionTextColor", 5, 0xFFFFFF)
        
    endif
  
EndFunction

