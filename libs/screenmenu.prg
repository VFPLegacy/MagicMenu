Procedure CreateSysMenu
	try
		Release Pad _pad_MagicMenu of _Msysmenu
	Catch
	EndTry

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
	Define Bar 1 Of _Mgm_Nuevo Prompt _Screen.oHelper.oLanguage.Translate("_6P50KGU2L") PICTRES _Mwz_import ;
		MESSAGE _Screen.oHelper.oLanguage.Translate("_6P50KGU2L", 2)
	On Selection Bar 1 Of _Mgm_Nuevo _Screen.oHelper.oConsole.newProject()

	Define Bar 2 Of _Mgm_Nuevo Prompt _Screen.oHelper.oLanguage.Translate("_6P50KIJGC")	PICTRES _MWZ_WEBSERVICES ;
		MESSAGE _Screen.oHelper.oLanguage.Translate("_6P50KIJGC", 2)
	On Selection Bar 2 Of _Mgm_Nuevo _Screen.oHelper.oSite.newSite()

	Define Bar 3 Of _Mgm_Nuevo Prompt _Screen.oHelper.oLanguage.Translate("_6P50KI1K9")	PICTRES _MTI_FOXCODE ;
		MESSAGE _Screen.oHelper.oLanguage.Translate("_6P50KI1K9", 2)
	On Selection Bar 3 Of _Mgm_Nuevo _Screen.oHelper.oService.newService()

	Define Bar 2 Of _Msm_MagicMenu Prompt "\-"

	** Proyecto
	Define Bar 3 Of _Msm_MagicMenu Prompt _screen.oHelper.oLanguage.Translate("_6RJ112FZ4") PICTRES _MED_PREF ;
		MESSAGE _Screen.oHelper.oLanguage.Translate("_6RJ112FZ4", 2) SKIP FOR EMPTY(_screen.cProjectType)

	On Bar 3 Of _Msm_MagicMenu Activate Popup _Mgm_Proyecto
	Define Popup _Mgm_Proyecto Margin Relative Shadow Color Scheme 4	

	** Actualizar Runtime
	Define Bar 1 Of _Mgm_Proyecto Prompt _Screen.oHelper.oLanguage.Translate("_6QQ1B4K8T") 	PICTRES _MWZ_WEBPUBLISHING ;
		MESSAGE _Screen.oHelper.oLanguage.Translate("_6QQ1B4K8T", 2) SKIP FOR EMPTY(_screen.cProjectType)
		*key CTRL+F7
	On Selection Bar 1 Of _Mgm_Proyecto _screen.oHelper.oProject.UpdateRuntimes()
	
	** Iniciar Servicio
	Define Bar 2 Of _Mgm_Proyecto Prompt _Screen.oHelper.oLanguage.Translate("_6PH11SWT8") 	PICTRES _MPR_RESUM ;
		MESSAGE _Screen.oHelper.oLanguage.Translate("_6PH11SWT8", 2) SKIP FOR !inlist(_screen.cProjectType, 'SRVEXE', 'WEBAPP')
		*KEY CTRL+F5
	On Selection Bar 2 Of _Mgm_Proyecto _screen.oHelper.oService.Start()
	
	** Detener Servicio
	Define Bar 3 Of _Mgm_Proyecto Prompt _Screen.oHelper.oLanguage.Translate("_6PH11TFJY") 	PICTRES _MPR_CANCL ;
		MESSAGE _Screen.oHelper.oLanguage.Translate("_6PH11TFJY", 2) SKIP FOR !inlist(_screen.cProjectType, 'SRVEXE', 'WEBAPP')
		*KEY CTRL+F6
	On Selection Bar 3 Of _Mgm_Proyecto _screen.oHelper.oService.Stop()

	** Abrir carpeta del proyecto
	Define Bar 4 Of _Mgm_Proyecto Prompt _screen.oHelper.oLanguage.Translate("_6RJ1B9VMR")	PICTRES _MFI_OPEN ;
		MESSAGE _screen.oHelper.oLanguage.Translate("_6RJ1B9VMR",2) SKIP FOR EMPTY(_screen.cProjectType)
		*KEY CTRL+F8
	On Selection Bar 4 Of _Mgm_Proyecto _screen.oHelper.oProject.OpenHomeDir()


	Define Bar 5 Of _Msm_MagicMenu Prompt "\-"
	
	Define Bar 6 of _Msm_MagicMenu prompt _Screen.oHelper.oLanguage.Translate("_6RR13H6B6") pictres _MFI_OPEN ;
		message _Screen.oHelper.oLanguage.Translate("_6RR13H6B6", 2) 
	On Selection Bar 6 of _Msm_MagicMenu _Screen.oHelper.oSite.OpenExamples()

	* Help Pad
	Define Bar 7 Of _Msm_MagicMenu Prompt _screen.oHelper.oLanguage.Translate("_6RI1CS1HU") PICTRES _Mst_hpsch ;
		MESSAGE _screen.oHelper.oLanguage.Translate("_6RI1CS1HU", 2)
	On Selection Bar 7 Of _Msm_MagicMenu _Screen.oHelper.HelpMessage()

Endproc
