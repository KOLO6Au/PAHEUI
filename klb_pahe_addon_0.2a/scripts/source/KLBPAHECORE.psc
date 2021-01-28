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
String[] GlobContent
String[] GlobContent_desc
int result
Event OnInit()
     RegisterForKey(38) ;L KE

   playerref=Game.GetPlayer()
  
  Debug.Notification("Radial Menu is successfully registered.")
EndEvent


Event OnKeyUp(int keyCode, float holdTime)
    if (!Utility.IsInMenuMode())
    if keyCode == 38
        croshref=GetCurrentCrosshairRef() as Actor
        if croshref.IsInFaction(PAHPlayerSlaveFaction)==1
            ShowGlobMenu(croshref)
    endif
   endif
endif
EndEvent

Function ShowGlobMenu(Actor KTarg)
    uiwheelmenu wheelMenu = uiextensions.GetMenu("uiwheelmenu", false) as uiwheelmenu
    wheelMenu.ResetMenu()
    m_slave = PAHDiags.GetSlave(croshref)
    GlobContent = new String[8]
    GlobContent[0] = "$KLB_OPT1A"
    GlobContent[1] = "$KLB_OPT2"
    GlobContent[2] = "$KLB_OPT3"
    GlobContent[3] = "$KLB_OPT4"
    GlobContent[4] = "$KLB_OPT5"
    GlobContent[5] = "$KLB_OPT6"
    GlobContent[6] = "$KLB_OPT7"
    GlobContent[7] = "$KLB_OPT8"
    GlobContent_desc = new String[8]
    GlobContent_desc[0] = "$KLB_OPTD1"
    GlobContent_desc[1] = "$KLB_OPTD2"
    GlobContent_desc[2] = "$KLB_OPTD3"
    GlobContent_desc[3] = "$KLB_OPTD4"
    GlobContent_desc[4] = "$KLB_OPTD5N"
    GlobContent_desc[5] = "$KLB_OPTD6"
    GlobContent_desc[6] = "$KLB_OPTD7"
    GlobContent_desc[7] = "$KLB_OPTD8"
    
     if croshref.isinfaction(PAHBEFollowing)
        GlobContent[0] = "$KLB_OPT1B"
        GlobContent_desc[0] = "$KLB_OPTD1"
     ElseIf croshref.isinfaction(PAHBEWaiting)
        GlobContent[0] = "$KLB_OPT1A"
        GlobContent_desc[0] = "$KLB_OPTD1Y"
     Else
        GlobContent_desc[0] = "$KLB_OPTD1U"
     endif
 
     if  m_slave.should_fight_for_player == False
        GlobContent_desc[4] = "$KLB_OPTD5N"
     Else
        GlobContent_desc[4] = "$KLB_OPTD5Y"
    endif
    
    Int p = 0
    while p < GlobContent.length
        wheelMenu.SetPropertyIndexString("optionLabelText", p, GlobContent[p])
        wheelMenu.SetPropertyIndexString("optionText", p, GlobContent_desc[p])
        wheelMenu.SetPropertyIndexBool("optionenabled", p, true)
        p += 1
        wheelMenu.SetPropertyIndexBool("optionenabled", 7, false)
    endWhile
    Int selected = wheelMenu.OpenMenu(KTarg, none)
    If selected == 0
        if croshref.isinfaction(PAHBEFollowing)
        PAHDiagS.Wait(croshref)
        ElseIf croshref.isinfaction(PAHBEWaiting)
        PAHDiagS.Follow(croshref)
        EndIf
    elseIf selected == 1
          if croshref.IsDoingFavor()
          Else
           croshref.SetDoingFavor()
          EndIf    
    elseIf selected == 2
          croshref.OpenInventory(True)
    elseIf selected ==3 
          PAHDiagS.OpenBackpack(croshref)
    elseIf selected ==4 
        if m_slave.should_fight_for_player == False
         PAHDiagS.CommandDoCombat(croshref)
        Else
         PAHDiagS.CommandNoLongerDoCombat(croshref)
        endif
    elseIf selected ==5 
        PAHDiagS.Strip(croshref)
    elseIf selected ==6 
           PAHSlaveInfoMessage.Show(\
        m_slave.submission, \
        m_slave.combat_training, \
        m_slave.anger_training, \
        m_slave.respect_training, \
        m_slave.pose_training, \
        m_slave.sex_training, \
        m_slave.fear_training \
        ) 
    elseIf selected ==7 
       
     endIf
    
    
EndFunction





