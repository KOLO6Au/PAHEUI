Scriptname KLBZaZSPellEff extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
     zbfBondageShell zbf = zbfBondageShell.GetApi()
     int zbfmaskk =zbf.WornEffectMask(akTarget)
     zbf.ApplyModifiersMask(akTarget, zbfmaskk)
EndEvent