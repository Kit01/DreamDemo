/** Basic Gametype **/
class DDMain extends GameInfo;

event PostBeginPlay()
{
    `log("Welcome to DreamDemo!");
}

defaultproperties
{
	bDelayedStart=false
	bRestartLevel=false
	Name="Default__DDMain"

	DefaultPawnClass=class'DDBasePlayerPawn'
	PlayerControllerClass=class'DDBasePlayerController'

	//HUDType=class'DDHUD'
	bUseClassicHUD=true
}
