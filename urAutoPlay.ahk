version := 0.09

order := Object()
pillz := Object()

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  ;;;
;;  ;;;;;;;;;;;                                   ;;;;;;;;;;;  ;;;
;;  ;;;;;;;;;;;         Configurazione BOT        ;;;;;;;;;;;  ;;;
;;  ;;;;;;;;;;;                                   ;;;;;;;;;;;  ;;;
;;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; prima a essere giocata
				order[1] :=		2
				pillz[1] :=		3
		; seconda a essere giocata
				order[2] :=		3
				pillz[2] :=		1
		; terza a essere giocata
				order[3] :=		4
				pillz[3] :=		3
		; quarta a essere giocata
				order[4] :=		1
				pillz[4] :=		5

		; mettere a 1 per pillz random (massimo 12 nella partita)
				randomPillz :=	0
				
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		; mettere a 1 se si vuole che giochi solo nelle ore del TQ
				onlyTQ := 0				

;;  ;;;;;;;;;;;                                   ;;;;;;;;;;;  ;;;
;;  ;;;;;;;;;;;                                   ;;;;;;;;;;;  ;;;
;;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  ;;;
;;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

running := 0

topPixel := 0
leftPixel := 0

selected := 0



#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#Singleinstance force

#MaxThreadsPerHotkey 2
#InstallMouseHook

CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

checkForUpdate(version)


if(randomPillz)
	setRandomPillz()

^k:: ;autoPlay
{
	running := !running
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
	if(onlyTQ && mod(A_Hour,2) <> 0 &&  A_Min > 4) {
		sleepTime := (60 - A_min) * 60 * 1000
		sleep, %sleepTime%
		goto mRestart
	}
	; premi Tasto Combatti
	mClick(12, 486)
	sleep 300
	; premi eventuale tasto missioni
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
		mClick(366, 470)
	}
	sleep 300
	if(!running) {
		return
	}
	; premi Tasto Combatti
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
				leftPixel := FoundX - 628
				topPixel := FoundY - 11
			}
		}
		else
		{
			leftPixel := FoundX - 628
			topPixel := FoundY - 11
		}
	}
	else
	{
		leftPixel := FoundX - 551
		topPixel := FoundY - 10
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
		leftPixel := FoundX - 304
		topPixel := FoundY
		mClick(363,480)
		sleep 300
		Send {Enter}
		sleep 2000
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
	x := order[pos] * (126 + 45) - 63
	mClick(x,430)
	Sleep 500
	Loop, %rep% {
		if(!running) {
			return
		}
		; premi Tasto +
		mClick(600, 250)
		Sleep 100
	}
	Sleep 100
	if(!running) {
		return
	}
	; premi Tasto Combatti
	mClick(526, 313)
	sleep 300
	; premi esc
	Send {Escape}
}

setRandomPillz() {
	Global pillz
	Random, r, 0, 6
	pillz[1] := r
	Random, r, 0, 6
	pillz[2] := r
	rem := 12 - pillz[1] - pillz[2]
	Random, r, 0, rem
	pillz[3] := r
	pillz[4] := rem - pillz[3]
}

checkForUpdate(version) {
	URL := "https://raw.githubusercontent.com/kalup/URScripts/master/urAutoPlay.ahk"
	UrlDownloadToFile, %URL%, tmp.ahk
	if(ErrorLevel = 1)
	{
		MsgBox Impossible to connect to remote URL: %URL%
		return
	}
	FileReadLine, newVersion, tmp.ahk, 1
	if(ErrorLevel = 1)
		return
	StringReplace newVersion, newVersion, "version := "
	if(newVersion > version)
	{
		MsgBox New Version
	}
}
