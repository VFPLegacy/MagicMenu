Define Class Base as Session
	oRequest 	= .NULL.
	oResponse 	= .NULL.
	oJson 		= .NULL.
	oFoxServer 	= .null.
	oHelper		= .null.
	nLastID	 	= 0
	cMethod		= ""
	cEnvProg	= ""
	cAllowedOrigins = "*"

	Procedure loadJsonFox
		If Type('_screen.json') == 'U' or Type('_screen.json.version') == 'U'
			Do LocFile("JSONFox", "app")
			_screen.json.lShowErrors = .F.
		EndIf
	EndProc

	Procedure ParseJsonBodyFromRequest
		this.loadJsonFox()
		this.oJson = _Screen.json.parse(This.oRequest.GetBody())
	EndProc
	
	Procedure cursorToJSON(tcCursor, tbCurrentRow) as memo
		this.loadJsonFox()
		Local lcResult, i
		lcResult = '['
		i = 0
		Select (tcCursor)
		If tbCurrentRow
			Scatter memo name loRow
			lcResult = lcResult + _screen.json.encode(loRow, "", .t., .t.)
		else
			Scan
				Scatter memo name loRow
				i = i + 1
				If i > 1
					lcResult = lcResult + ','
				EndIf
				lcResult = lcResult + _screen.json.encode(loRow, "", .t., .t.)
			EndScan
		EndIf
		lcResult = lcResult + ']'

		Return lcResult
	EndProc

	Function MethodExists(tcMethod as String) as Boolean
		Return PemStatus(this, tcMethod, 5) and PemStatus(this, tcMethod, 3) == 'Method'
	EndFunc
	
	Function GetLastID as Integer
		Return this.nLastID
	EndFunc

	Procedure SetLastID(tnID as Integer)
		this.nLastID = tnID
	endproc

	Function GetMethod as String
		Return this.cMethod
	EndFunc

	procedure SetMethod(tcMethod as String)
		this.cMethod = tcMethod
	EndProc

	Procedure CallMethod(tcMethod as String)
		Evaluate(Textmerge('this.<<tcMethod>>()'))
	endproc	
EndDefine