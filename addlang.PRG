LPARAMETERS tcCaptionES, tcCaptionEN, tcCaptionCN, tcHintES, tcHintEN, tcHintCN


IF EMPTY(tcCaptionES)
	tcCaptionES = ""
ENDIF

IF EMPTY(tcCaptionEN)
	tcCaptionEN = ""
ENDIF

*!* add by xinjie  2024.01.28
IF EMPTY(tcCaptionCN)
	tcCaptionCN = ""
EndIf
IF EMPTY(tcHintES)
	tcHintES = ""
ENDIF

IF EMPTY(tcHintEN)
	tcHintEN = ""
EndIf

*!* add by xinjie  2024.01.28
IF EMPTY(tcHintCN)
	tcHintCN = ""
EndIf


lcUnique = SYS(2015)

USE f:\desarrollo\github\vfplegacy\magicmenu\lang\languages.dbf AGAIN IN 0 ALIAS Languages
APPEND BLANK
REPLACE control_id 	WITH lcUnique
replace caption_es 	WITH tcCaptionES
replace caption_en 	WITH tcCaptionEN
replace hint_es 	WITH tcHintES
replace hint_en 	WITH tcHintEN

*!* add by xinjie  2024.01.28
replace caption_cn 	WITH tcCaptionCN
replace hint_cn 	WITH tcHintCN

USE IN languages

RETURN '_screen.oHelper.oLanguage.Translate("' + lcUnique + '")'
