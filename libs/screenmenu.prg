Procedure CreateSysMenu
  * MagicMenu Pad
  Define Pad _pad_MagicMenu Of _Msysmenu Prompt "\<MagicMenu"
  On Pad _pad_MagicMenu Of _Msysmenu Activate Popup _Msm_MagicMenu
  Define Popup _Msm_MagicMenu Margin Relative Shadow Color Scheme 4

  ** New Popup
  Define Bar 1 Of _Msm_MagicMenu Prompt _Screen.oHelper.oLanguage.Translate("_6P50J4SVE") PICTRES _MWZ_WEBPUBLISHING ;
    MESSAGE _Screen.oHelper.oLanguage.Translate("_6P50J4SVE", 2)

  On Bar 1 Of _Msm_MagicMenu Activate Popup _Mgm_Nuevo
  Define Popup _Mgm_Nuevo Margin Relative Shadow Color Scheme 4

  ** New Popup bars
  ** Console Application
  Define Bar 1 Of _Mgm_Nuevo Prompt _Screen.oHelper.oLanguage.Translate("_6P50KGU2L") 	PICTRES _Mwz_import ;
    MESSAGE _Screen.oHelper.oLanguage.Translate("_6P50KGU2L", 2)
  On Selection Bar 1 Of _Mgm_Nuevo _Screen.oHelper.oConsole.newProject()

  Define Bar 2 Of _Mgm_Nuevo Prompt _Screen.oHelper.oLanguage.Translate("_6P50KIJGC")	PICTRES _MWZ_WEBSERVICES ;
    MESSAGE _Screen.oHelper.oLanguage.Translate("_6P50KIJGC", 2)
  On Selection Bar 2 Of _Mgm_Nuevo _Screen.oHelper.oSite.newSite()

  Define Bar 3 Of _Mgm_Nuevo Prompt _Screen.oHelper.oLanguage.Translate("_6P50KI1K9")	PICTRES _MTI_FOXCODE ;
    MESSAGE _Screen.oHelper.oLanguage.Translate("_6P50KI1K9", 2)
  On Selection Bar 3 Of _Mgm_Nuevo _Screen.oHelper.oService.newService()

  * Help Pad
  Define Bar 2 Of _Msm_MagicMenu Prompt _Screen.oHelper.oLanguage.Translate("_6RI1CS1HU") PICTRES _Mst_hpsch ;
    MESSAGE _Screen.oHelper.oLanguage.Translate("_6RI1CS1HU", 2)
  ON SELECTION BAR 2 OF _Msm_MagicMenu _screen.oHelper.HelpMessage()

Endproc

Procedure CreateProjectMenu(tcProjectType)
	
Endproc