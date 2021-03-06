version := 0.300

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#Singleinstance force

#MaxThreadsPerHotkey 2
#InstallMouseHook

CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

checkForUpdate(version)

order := Object()
pillz := Object()

randomPillz := 0
maxPillz := 12

onlyTQ := 0

running := 0

topPixel := 0
leftPixel := 0

selected := 0

newVersion := 1

loadIni()

if(randomPillz)
	setRandomPillz()
	
return

^l:: ;reload INI
{
	MsgBox Reloaded data
	loadIni()
	return
}

^j:: ;emergency stop
{
	running:= 0
	MsgBox Stopped.
	return
}

^k:: ;autoPlay
{
	running := !running
	if(running)
		MsgBox Started.
	else
		MsgBox Stopped.
	mBegin:
	if(!running) {
		return
	}
	; premi esc
	Send {Escape}
	sleep 300
	
	
	
	mSearchHomepage:
	if(!running) {
		return
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 %A_ScriptDir%\NewsLogoHomepage.png
	if ErrorLevel = 2
	{
		MsgBox Missing NewsLogoHomepage.png file.
		return
	}
	else if ErrorLevel = 0
	{
		if(onlyTQ && mod(A_Hour,2) <> 0) {
			sleepTime := (60 - A_min) * 60 * 1000
			sleep, %sleepTime%
			goto mRestart
		}
		Send {Enter}
		sleep 2000
		goto mBegin
	}
	
	
	
	mSearchResult:
	if(!running) {
		return
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 %A_ScriptDir%\resultLogo.png
	if ErrorLevel = 2
	{
		MsgBox Missing resultLogo.png file.
		return
	}
	else if ErrorLevel = 1
	{
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 %A_ScriptDir%\resultLogoDark.png
		if ErrorLevel = 2
		{
			MsgBox Missing resultLogoDark.png file.
			return
		}
		else if ErrorLevel = 1
		{
			goto mSearchMain
		}
	}
	leftPixel := FoundX
	topPixel := FoundY
	if(!running) {
		return
	}
	if(onlyTQ && mod(A_Hour,2) <> 0) {
		sleepTime := (60 - A_min) * 60 * 1000
		sleep, %sleepTime%
		goto mRestart
	}
	; premi Tasto Combatti
	if(newVersion = 1)
		mClick(14, 576)
	else
		mClick(12, 486)
	sleep 300
	; premi eventuale tasto missioni; TOCHECK
	if(newVersion = 1)
		mClick(495, 300)
	else
		mClick(365, 233)
	; controlla se hai ottenuto una carta
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 %A_ScriptDir%\cartaVinta.png
	if ErrorLevel = 2
	{
		MsgBox Missing cartaVinta.png file.
		return
	}
	else if ErrorLevel = 0
	{
	; premi eventualmente sulla carta vinta per non aggiungerla al mazzo; TOCHECK
		if(newVersion = 1)
			mClick(495, 513)
		else
			mClick(366, 470)
	}
	sleep 300
	if(!running) {
		return
	}
	; premi Tasto Combatti
	if(newVersion = 1)
		mClick(14, 576)
	else
		mClick(12, 486)
	if(randomPillz)
		setRandomPillz()
	goto mRestart

	
	
	mSearchMain:
	if(!running) {
		return
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 %A_ScriptDir%\buttonLight.png
	if ErrorLevel = 2
	{
		MsgBox Missing buttonLight.png file.
		return
	}
	else if ErrorLevel = 1
	{
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 %A_ScriptDir%\buttonMedium.png
		if ErrorLevel = 2
		{
			MsgBox Missing buttonMedium.png file.
			return
		}
		else if ErrorLevel = 1
		{
			ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *3 %A_ScriptDir%\buttonDark.png
			if ErrorLevel = 2
			{
				MsgBox Missing buttonDark.png file.
				return
			}
			else if ErrorLevel = 1
			{
				goto mBackToMenu
			}
			else
			{
				if(newVersion = 1) {
					leftPixel := FoundX - 887
					topPixel := FoundY - 11
				} else {
					leftPixel := FoundX - 628
					topPixel := FoundY - 11
				}
			}
		}
		else
		{
			if(newVersion = 1) {
				leftPixel := FoundX - 887
				topPixel := FoundY - 11
			} else {
				leftPixel := FoundX - 628
				topPixel := FoundY - 11
			}
		}
	}
	else
	{
		if(newVersion = 1) {
			leftPixel := FoundX - 810
			topPixel := FoundY - 10
		} else {
			leftPixel := FoundX - 551
			topPixel := FoundY - 10
		}
	}
	
	mPlayRound:
	selected := 1
	Loop, 4 {
		if(!running) {
			return
		}
		playCardAtPosition(selected)
		selected += 1
	}
	; premi l'eventuale pulsante non è il tuo turno
	if(newVersion = 1)
		mClick(495,352)
	else
		mClick(366,297)
	
	
	
	mBackToMenu:
	if(!running) {
		return
	}
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 %A_ScriptDir%\backToMenu.png
	if ErrorLevel = 2
	{
		MsgBox Missing backToMenu.png file.
		return
	}
	else if ErrorLevel = 0
	{
		sleep 2000
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 %A_ScriptDir%\backToMenu.png
		if ErrorLevel = 2
		{
			MsgBox Missing backToMenu.png file.
			return
		}
		else if ErrorLevel = 0
		{
			sleep 4000
			ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 %A_ScriptDir%\backToMenu.png
			if ErrorLevel = 2
			{
				MsgBox Missing backToMenu.png file.
				return
			}
			else if ErrorLevel = 0
			{
				sleep 8000
				ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *20 %A_ScriptDir%\backToMenu.png
				if ErrorLevel = 2
				{
					MsgBox Missing backToMenu.png file.
					return
				}
				else if ErrorLevel = 0
				{
					if(newVersion = 1) {
						leftPixel := FoundX
						topPixel := FoundY
						mClick(500,577)
					} else {
						leftPixel := FoundX
						topPixel := FoundY
						mClick(370,465)
					}
					sleep 300
					Send {Enter}
					sleep 2000
				}
			}
		}
	}
	
	
	
	
	
	mRestart:
	sleep 300
	if(!running) {
		return
	}
	goto mBegin
}

mClick(offX, offY) {
	Global leftPixel
	Global topPixel
	x := offX + leftPixel
	y := offY + topPixel
	MouseMove, x, y
	Click Left
}

playCardAtPosition(pos) {
	Global order
	Global pillz
	Global running
	rep := pillz[pos]
	; premi la carta
	if( newVersion = 1) {
		x := order[pos] * (157 + 72) - 78
		mClick(x,470)
	} else {
		x := order[pos] * (126 + 45) - 63
		mClick(x,430)
	}
	Sleep 500
	Loop, %rep% {
		if(!running) {
			return
		}
		; premi Tasto +
		if( newVersion = 1)
			mClick(718, 300)
		else
			mClick(600, 250)
		Sleep 60
	}
	Sleep 100
	if(!running) {
		return
	}
	; premi Tasto Combatti
	if( newVersion = 1)
		mClick(704, 359)
	else
		mClick(526, 313)
	sleep 300
	; premi esc
	Send {Escape}
}

setRandomPillz() {
	Global pillz
	Global maxPillz
	sumR := 0
	Random, r, 0, 100
	sumR += r
	pillz[1] := r
	Random, r, 0, 100
	sumR += r
	pillz[2] := r
	Random, r, 0, 100
	sumR += r
	pillz[3] := r
	Random, r, 0, 100
	sumR += r
	pillz[4] := r
	pillz[1] := Round(pillz[1]/sumR*12)
	pillz[2] := Round(pillz[2]/sumR*12)
	pillz[3] := Round(pillz[3]/sumR*12)
	pillz[4] := maxPillz - pillz[1] - pillz[2] - pillz[3]
}

checkForUpdate(version) {
	Random, rand, 1, 10255
	UrlDownloadToFile, https://raw.githubusercontent.com/kalup/URScripts/master/Game/urAutoPlay.ahk?%rand%, tmp.ahk
	;if(ErrorLevel = 1)
	;{
	;	MsgBox Impossible to connect to remote URL: %URL%
	;}
	FileReadLine, newVersion, tmp.ahk, 1
	if(ErrorLevel = 1)
		return
	StringReplace newVersion, newVersion,version := 
	if(newVersion > version)
	{
		FileDelete, urAutoPlay.ahk.old
		FileMove, urAutoPlay.ahk, urAutoPlay.ahk.old
		FileMove, tmp.ahk, urAutoPlay.ahk
		MsgBox New Version, please restart
		ExitApp
	}
	FileDelete, tmp.ahk
}

loadIni() {
	Global pillz
	Global order
	Global randomPillz
	Global maxPillz
	Global onlyTQ
	Global newVersion
	; prima a essere giocata
	IniRead, o1, urAutoPlaySettings.ini, Order, Card_1, -1
	if(o1 = -1) {
		IniWrite, 1, urAutoPlaySettings.ini, Order, Card_1
		o1 := 1
	}
	IniRead, p1, urAutoPlaySettings.ini, Pillz, Card_1, -1
	if(p1 = -1) {
		IniWrite, 3, urAutoPlaySettings.ini, Pillz, Card_1
		p1 := 3
	}
	; seconda a essere giocata
	IniRead, o2, urAutoPlaySettings.ini, Order, Card_2, -1
	if(o2 = -1) {
		IniWrite, 2, urAutoPlaySettings.ini, Order, Card_2
		o2 := 2
	}
	IniRead, p2, urAutoPlaySettings.ini, Pillz, Card_2, -1
	if(p2 = -1) {
		IniWrite, 3, urAutoPlaySettings.ini, Pillz, Card_2
		p2 := 3
	}
	; terza a essere giocata
	IniRead, o3, urAutoPlaySettings.ini, Order, Card_3, -1
	if(o3 = -1) {
		IniWrite, 3, urAutoPlaySettings.ini, Order, Card_3
		o3 := 3
	}
	IniRead, p3, urAutoPlaySettings.ini, Pillz, Card_3, -1
	if(p3 = -1) {
		IniWrite, 3, urAutoPlaySettings.ini, Pillz, Card_3
		p3 := 3
	}
	; quarta a essere giocata
	IniRead, o4, urAutoPlaySettings.ini, Order, Card_4, -1
	if(o4 = -1) {
		IniWrite, 4, urAutoPlaySettings.ini, Order, Card_4
		o4 := 4
	}
	IniRead, p4, urAutoPlaySettings.ini, Pillz, Card_4, -1
	if(p4 = -1) {
		IniWrite, 3, urAutoPlaySettings.ini, Pillz, Card_4
		p4 := 3
	}

	; se a 1 mette pillz a random
	IniRead, randomPillz, urAutoPlaySettings.ini, Pillz, randomPillz, -1
	if(randomPillz = -1) {
		IniWrite, 0, urAutoPlaySettings.ini, Pillz, randomPillz
		randomPillz := 0
	}
	IniRead, maxPillz, urAutoPlaySettings.ini, Pillz, maxPillz, -1
	if(maxPillz = -1) {
		IniWrite, 12, urAutoPlaySettings.ini, Pillz, maxPillz
		maxPillz := 12
	}

	; se a 1 gioca solo nelle ore del TQ
	IniRead, onlyTQ, urAutoPlaySettings.ini, Time, onlyTQ, -1
	if(onlyTQ = -1) {
		IniWrite, 0, urAutoPlaySettings.ini, Time, onlyTQ
		onlyTQ := 0
	}

	; se a 1 considera di giocare con la nuova versione di Urban, altrimenti con la vecchia
	IniRead, newVersion, urAutoPlaySettings.ini, Game, newVersion, -1
	if(newVersion = -1) {
		IniWrite, 1, urAutoPlaySettings.ini, Game, newVersion
		newVersion := 1
	}
	
	order[1] := o1
	order[2] := o2
	order[3] := o3
	order[4] := o4
	pillz[1] := p1
	pillz[2] := p2
	pillz[3] := p3
	pillz[4] := p4
}
