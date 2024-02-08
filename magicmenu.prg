Lparameters tcLanguage, tnToolBarSize, tbUseNative

Do Case
** DEBUG
Case Pcount() = 0
	* tcLanguage	= "ES"
	* fixed by xinjie  2024.01.25		Use the return value of Version(3) to Confirm the default language
	* This is where there is a place reserved for localization in other languages
	* https://www.vfphelp.com/help/_5wn12ptn9.htm
	Do Case
		Case Version(3) = [00]		&& English
			tcLanguage	= "EN"

		* Case Version(3) = [07]		&& Russian

		* Case Version(3) = [33]		&& French

		Case Version(3) = [34]		&& Spanish
			tcLanguage = "ES"
		* Case Version(3) = [42]		&& Czech

		* Case Version(3) = [49]		&& German

		* Case Version(3) = [82]		&& Korean

		Case Version(3) = [86]		&& Simplified Chinese
			tcLanguage = "CN"
			
		* Case Version(3) = [88]		&& Traditional Chinese
		
		Otherwise 
			* Add comments by xinjie  2024.01.25		We need to respect the author, at least.
			tcLanguage	= "ES"
	EndCase 
	
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
	AddProperty(_Screen.oMagicMenu, "cVersion", "2.0.2")
	AddProperty(_Screen.oMagicMenu, "bDebugMode", .F.)
	* AddProperty(_Screen.oMagicMenu, "cVFPDir", "C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe")
	* fixed by xinjie  2024.01.25	Use home(1) instead of hardcoding the path
	AddProperty(_Screen.oMagicMenu, "cVFPDir", Home(1) + "vfp9.exe")
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

If Not Inlist(Upper(tcLanguage), "ES", "EN", "CN")
	* Messagebox("Wrong value for parameter: tcLanguage." + Chr(13) + Chr(10) + "Please send 'ES' for Spanish or 'EN' for English.", 16, "Error")

	* fixed by xinjie  2024.01.23	Use the return value of Version(3) to make the message appear in the native language
	* This is where there is a place reserved for localization in other languages
	* https://www.vfphelp.com/help/_5wn12ptn9.htm
	* Translated from English to other by Bing
	Do Case 
		Case Version(3) = [00]		&& English
			Messagebox("Wrong value for parameter: tcLanguage." + Chr(13) + Chr(10) + "Please send 'ES' for Spanish or 'EN' for English or 'CN' for Chinese Simplified.", 16, "Error")

		* Case Version(3) = [07]		&& Russian

		* Case Version(3) = [33]		&& French

		Case Version(3) = [34]		&& Spanish
			Messagebox("Valor incorrecto para el par醡etro: tcLanguage." + Chr(13) + Chr(10) + "Por favor, env韊 'ES' para espa駉l o 'EN' para ingl閟 o 'CN' para chino simplificado.", 16, "Error")

		* Case Version(3) = [42]		&& Czech

		* Case Version(3) = [49]		&& German

		* Case Version(3) = [82]		&& Korean

		Case Version(3) = [86]		&& Simplified Chinese
			Messagebox("参数值错误: tcLanguage." + Chr(13) + Chr(10) + "西班牙语请使用 'ES'，英语请使用 'EN'，简体中文请使用 'CN'", 16, "错误")
			
		* Case Version(3) = [88]		&& Traditional Chinese
		
		Otherwise 
			* Add comments by xinjie  2024.01.25		After all, English is the most spoken language in the world.
			Messagebox("Wrong value for parameter: tcLanguage." + Chr(13) + Chr(10) + "Please send 'ES' for Spanish or 'EN' for English or 'CN' for Chinese Simplified.", 16, "Error")
	EndCase 

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
