Lparameters tcLanguage, tnToolBarSize, tbUseNative

Do Case
** DEBUG
Case Pcount() = 0
	tcLanguage = "ES"
	tnToolBarSize = 32
	tbUseNative = .T.
** DEBUG
Case Pcount() = 1
	tnToolBarSize = 32
	tbUseNative = .T.
Case Pcount() = 2 and Type('tnToolBarSize') = 'L'
	tbUseNative = tnToolBarSize
Endcase

If Not Pemstatus(_Screen, 'oLang', 5)
	_Screen.AddProperty('oLang', .Null.)
Endif

If Not Pemstatus(_Screen, 'oHelper', 5)
	_Screen.AddProperty('oHelper', .Null.)
Endif

If Not Pemstatus(_Screen, 'oBridge', 5)
	_Screen.AddProperty('oBridge', .Null.)
Endif

If Not Pemstatus(_Screen, 'oVfpStretch', 5)
	_Screen.AddProperty('oVfpStretch', .Null.)
Endif

If Not Pemstatus(_Screen, 'oProjectManager', 5)
	_Screen.AddProperty('oProjectManager', .Null.)
Endif

If Not Pemstatus(_Screen, 'oActiveProject', 5)
	_Screen.AddProperty('oActiveProject', .Null.)
Endif

If Not Pemstatus(_Screen, 'cProjectType', 5)
	_Screen.AddProperty('cProjectType', "")
Endif

Local lbAlreadyLoaded
lbAlreadyLoaded = .T.
If !Pemstatus(_Screen, 'oMagicMenu', 5)
	lbAlreadyLoaded = .F.
	_Screen.AddProperty('oMagicMenu', Createobject("Empty"))
	AddProperty(_Screen.oMagicMenu, "oBarra", .Null.)
	AddProperty(_Screen.oMagicMenu, "cMainDir", Addbs(Justpath(Sys(16))))
	AddProperty(_Screen.oMagicMenu, "cDirBMP", Addbs(Justpath(Sys(16))) + 'bmps\')
	AddProperty(_Screen.oMagicMenu, "bUseNative", tbUseNative)
	AddProperty(_Screen.oMagicMenu, "cVersion", "1.2.5")
	AddProperty(_Screen.oMagicMenu, "bDebugMode", .F.)
	AddProperty(_Screen.oMagicMenu, "cVFPDir", "C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe")
	AddProperty(_Screen.oMagicMenu, "cTempDir", Addbs(Getenv("USERPROFILE")) + 'MagicMenu\')
	If Not Directory(_Screen.oMagicMenu.cTempDir)
		Mkdir (_Screen.oMagicMenu.cTempDir)
	Endif
Endif

If Empty(tcLanguage)
	tcLanguage = "ES"
Endif

If Empty(tnToolBarSize)
	tnToolBarSize = 16
Endif

If Not Inlist(Upper(tcLanguage), "ES", "EN")
	Messagebox("Wrong value for parameter: tcLanguage." + Chr(13) + Chr(10) + "Please send 'ES' for Spanish or 'EN' for English.", 16, "Error")
	Return
Endif

Cd (_Screen.oMagicMenu.cMainDir)
Set Default To (_Screen.oMagicMenu.cMainDir)

Set Path To "classes;bmps;lang;libs" Additive
Set Procedure To "VFPStretch" Additive
Set Classlib To "MagicMenu" Additive

If !lbAlreadyLoaded
	_Screen.oHelper 	= Createobject("Helper")
	_Screen.oLang 		= _Screen.oHelper.oLanguage.loadLanguage(Lower(tcLanguage))
	_Screen.oVFPStretch = Createobject("vfpStretch")
	If !Directory(_Screen.oMagicMenu.cMainDir + 'libs\')
		_Screen.oHelper.oSystem.ExtractDependencies()
	Endif

	* Load the wwDotNetBridge
	Do wwDotNetBridge
	InitializeDotnetVersion()
	_Screen.oBridge = getwwDotNetBridge()
EndIf

If tbUseNative
	Set Procedure To "ScreenMenu" Additive
	CreateSysMenu()
Else
	Local lcMenuClass
	lcMenuClass = "ToolBarMenuX" + Alltrim(Str(tnToolBarSize))
	_Screen.oMagicMenu.oBarra = Createobject(lcMenuClass)
	_Screen.oMagicMenu.oBarra.Show()
Endif
