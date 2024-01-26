LPARAMETERS tcLanguage, tnToolBarSize, tbUseNative

DO CASE
** DEBUG
CASE PCOUNT() = 0
* tcLanguage	= "ES"
* fixed by xinjie  2024.01.25		Use the return value of Version(3) to Confirm the default language
* This is where there is a place reserved for localization in other languages
* https://www.vfphelp.com/help/_5wn12ptn9.htm
	DO CASE
	CASE VERSION(3) = [00]		&& English
		tcLanguage	= "EN"

* Case Version(3) = [07]		&& Russian

* Case Version(3) = [33]		&& French

	CASE VERSION(3) = [34]		&& Spanish
		tcLanguage = "ES"
* Case Version(3) = [42]		&& Czech

* Case Version(3) = [49]		&& German

* Case Version(3) = [82]		&& Korean

	CASE VERSION(3) = [86]		&& Simplified Chinese
		tcLanguage = "CN"

* Case Version(3) = [88]		&& Traditional Chinese

	OTHERWISE
* Add comments by xinjie  2024.01.25		We need to respect the author, at least.
		tcLanguage	= "ES"
	ENDCASE

	tnToolBarSize = 32
	tbUseNative = .T.
** DEBUG
CASE PCOUNT() = 1
	tnToolBarSize = 32
	tbUseNative = .T.
CASE PCOUNT() = 2 AND TYPE('tnToolBarSize') = 'L'
	tbUseNative = tnToolBarSize
ENDCASE

IF NOT PEMSTATUS(_SCREEN, 'oLang', 5)
	_SCREEN.ADDPROPERTY('oLang', .NULL.)
ENDIF

IF NOT PEMSTATUS(_SCREEN, 'oHelper', 5)
	_SCREEN.ADDPROPERTY('oHelper', .NULL.)
ENDIF

IF NOT PEMSTATUS(_SCREEN, 'oBridge', 5)
	_SCREEN.ADDPROPERTY('oBridge', .NULL.)
ENDIF

IF NOT PEMSTATUS(_SCREEN, 'oVfpStretch', 5)
	_SCREEN.ADDPROPERTY('oVfpStretch', .NULL.)
ENDIF

IF NOT PEMSTATUS(_SCREEN, 'oProjectManager', 5)
	_SCREEN.ADDPROPERTY('oProjectManager', .NULL.)
ENDIF

IF NOT PEMSTATUS(_SCREEN, 'oActiveProject', 5)
	_SCREEN.ADDPROPERTY('oActiveProject', .NULL.)
ENDIF

IF NOT PEMSTATUS(_SCREEN, 'cProjectType', 5)
	_SCREEN.ADDPROPERTY('cProjectType', "")
ENDIF

LOCAL lbAlreadyLoaded
lbAlreadyLoaded = .T.
IF !PEMSTATUS(_SCREEN, 'oMagicMenu', 5)
	lbAlreadyLoaded = .F.
	_SCREEN.ADDPROPERTY('oMagicMenu', CREATEOBJECT("Empty"))
	ADDPROPERTY(_SCREEN.oMagicMenu, "oBarra", .NULL.)
	ADDPROPERTY(_SCREEN.oMagicMenu, "cMainDir", ADDBS(JUSTPATH(SYS(16))))
	ADDPROPERTY(_SCREEN.oMagicMenu, "cDirBMP", ADDBS(JUSTPATH(SYS(16))) + 'bmps\')
	ADDPROPERTY(_SCREEN.oMagicMenu, "bUseNative", tbUseNative)
	ADDPROPERTY(_SCREEN.oMagicMenu, "cVersion", "1.3.6")
	ADDPROPERTY(_SCREEN.oMagicMenu, "bDebugMode", .F.)
* AddProperty(_Screen.oMagicMenu, "cVFPDir", "C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe")
* fixed by xinjie  2024.01.25	Use home(1) instead of hardcoding the path
	ADDPROPERTY(_SCREEN.oMagicMenu, "cVFPDir", HOME(1) + "vfp9.exe")
	ADDPROPERTY(_SCREEN.oMagicMenu, "cTempDir", ADDBS(GETENV("USERPROFILE")) + 'MagicMenu\')
	IF NOT DIRECTORY(_SCREEN.oMagicMenu.cTempDir)
		MKDIR (_SCREEN.oMagicMenu.cTempDir)
	ENDIF
ENDIF

IF EMPTY(tcLanguage)
	tcLanguage = "ES"
ENDIF

IF EMPTY(tnToolBarSize)
	tnToolBarSize = 16
ENDIF

IF NOT INLIST(UPPER(tcLanguage), "ES", "EN", "CN")
* Messagebox("Wrong value for parameter: tcLanguage." + Chr(13) + Chr(10) + "Please send 'ES' for Spanish or 'EN' for English.", 16, "Error")

* fixed by xinjie  2024.01.23	Use the return value of Version(3) to make the message appear in the native language
* This is where there is a place reserved for localization in other languages
* https://www.vfphelp.com/help/_5wn12ptn9.htm
* Translated from English to other by Bing
	DO CASE
	CASE VERSION(3) = [00]		&& English
		MESSAGEBOX("Wrong value for parameter: tcLanguage." + CHR(13) + CHR(10) + "Please send 'ES' for Spanish or 'EN' for English or 'CN' for Chinese Simplified.", 16, "Error")

* Case Version(3) = [07]		&& Russian

* Case Version(3) = [33]		&& French

	CASE VERSION(3) = [34]		&& Spanish
		MESSAGEBOX("Valor incorrecto para el par醡etro: tcLanguage." + CHR(13) + CHR(10) + "Por favor, env韊 'ES' para espa駉l o 'EN' para ingl閟 o 'CN' para chino simplificado.", 16, "Error")

* Case Version(3) = [42]		&& Czech

* Case Version(3) = [49]		&& German

* Case Version(3) = [82]		&& Korean

	CASE VERSION(3) = [86]		&& Simplified Chinese
		MESSAGEBOX("参数值错误: tcLanguage." + CHR(13) + CHR(10) + "西班牙语请使用 'ES'，英语请使用 'EN'，简体中文请使用 'CN'", 16, "错误")

* Case Version(3) = [88]		&& Traditional Chinese

	OTHERWISE
* Add comments by xinjie  2024.01.25		After all, English is the most spoken language in the world.
		MESSAGEBOX("Wrong value for parameter: tcLanguage." + CHR(13) + CHR(10) + "Please send 'ES' for Spanish or 'EN' for English or 'CN' for Chinese Simplified.", 16, "Error")
	ENDCASE

	RETURN
ENDIF

CD (_SCREEN.oMagicMenu.cMainDir)
SET DEFAULT TO (_SCREEN.oMagicMenu.cMainDir)

SET PATH TO "classes;bmps;lang;libs" ADDITIVE
SET PROCEDURE TO "VFPStretch" ADDITIVE
SET CLASSLIB TO "MagicMenu" ADDITIVE

IF !lbAlreadyLoaded
	_SCREEN.oHelper 	= CREATEOBJECT("Helper")
	_SCREEN.oLang 		= _SCREEN.oHelper.oLanguage.loadLanguage(LOWER(tcLanguage))
	_SCREEN.oVFPStretch = CREATEOBJECT("vfpStretch")

	IF !DIRECTORY(_SCREEN.oMagicMenu.cMainDir + 'libs\')
		_SCREEN.oHelper.oSystem.ExtractDependencies()
	ENDIF

* Load the wwDotNetBridge
	DO wwDotNetBridge
	InitializeDotnetVersion()
	_SCREEN.oBridge = getwwDotNetBridge()
ENDIF

IF tbUseNative
	SET PROCEDURE TO "ScreenMenu" ADDITIVE
	CreateSysMenu()
ELSE
	LOCAL lcMenuClass
	lcMenuClass = "ToolBarMenuX" + ALLTRIM(STR(tnToolBarSize))
	_SCREEN.oMagicMenu.oBarra = CREATEOBJECT(lcMenuClass)
	_SCREEN.oMagicMenu.oBarra.SHOW()
ENDIF