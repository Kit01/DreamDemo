/** Base Player Controller Class **/
class DDBasePlayerController extends DDBaseController;

// Current location of camera and current location of camera's focus
var vector CurrentCameraLocation, OriginialCameraOffset, CurrentFocusLocation;
// Camera's distance from the focus location
var float CamDist;
// Factor to multiply player input by - reduce translation/rotation speed
var float RotationFactor, MoveSmoothFactor;

var float ChargeSpeed;


// Current view rotation of player
var rotator VRot;

var bool bManipulatingCam;

var bool bWallWalking;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    // Cache camera's distance from focus location
    CamDist = VSize(CurrentCameraLocation - CurrentFocusLocation);
}

function PlayerTick(float DeltaTime)
{
    local vector NewCamLoc, NewFocusLoc, X, Y, Z;

    super.PlayerTick(DeltaTime);

    if ( Pawn != none && bManipulatingCam )
    {
        NewFocusLoc = CurrentFocusLocation;

        NewFocusLoc += (Pawn.Location - NewFocusLoc) * MoveSmoothFactor;

        NewCamLoc = CurrentCameraLocation + (NewFocusLoc - CurrentFocusLocation);

        NewCamLoc -= RotationFactor * (PlayerInput.aMouseX * vect(0,1,0) >> VRot);

        NewCamLoc -= RotationFactor * (PlayerInput.aMouseY * vect(0,0,1) >> VRot);

        NewCamLoc = CamDist * normal(NewCamLoc - NewFocusLoc);

        NewCamLoc += NewFocusLoc;

        CurrentCameraLocation = NewCamLoc;

        CurrentFocusLocation = NewFocusLoc;
    }

    else if ( Pawn != none && !bManipulatingCam )
    {
        NewFocusLoc = CurrentFocusLocation;

        NewFocusLoc += (Pawn.Location - NewFocusLoc) * MoveSmoothFactor;

        NewCamLoc = CurrentCameraLocation + (NewFocusLoc - CurrentFocusLocation);

        NewCamLoc = CamDist * normal(NewCamLoc - NewFocusLoc);

        NewCamLoc += NewFocusLoc;

        if ( Pawn.Acceleration != vect(0,0,0) )
        {
            GetAxes(Pawn.Rotation, X, Y, Z);
            NewCamLoc -= (X * 220.0f) + (Y * 1) + (Z * 1);
        }
            // NewCamLoc += (Pawn.Location >> Pawn.Rotation) * 0.01f;

        CurrentCameraLocation = NewCamLoc;
        CurrentFocusLocation = NewFocusLoc;
    }
}

// Console command used to switch crawling mode on/off (better used with a key binding for example)
exec function ToggleWallWalk()
{
    `log("Toggling Wall Walking!");
    bWallWalking = !bWallWalking;
}

// Overrode function to translate/rotate player camera based on player input
simulated event GetPlayerViewPoint(out vector POVLocation, out Rotator POVRotation)
{
    super.GetPlayerViewPoint(POVLocation, POVRotation);

    // Assign camera location and rotation
    POVLocation = CurrentCameraLocation;
    POVRotation = rotator(CurrentFocusLocation - CurrentCameraLocation);

    // Assign current view rotation
    VRot = POVRotation;
}

exec function StartManipCamera()
{
    bManipulatingCam = true;
}

exec function StopManipCamera()
{
    bManipulatingCam = false;
}

event bool NotifyHitWall(vector HitNormal, actor HitActor)
{
    if( bWallWalking )
    {
        Pawn.SetPhysics(PHYS_Spider);
        Pawn.SetBase(HitActor, HitNormal);
        return true;
    }

    else
        Pawn.SetPhysics(PHYS_Walking);
}

exec function Dash()
{
    Pawn.SetPhysics(PHYS_FLYING);
    Pawn.Velocity = ChargeSpeed*Pawn.Velocity;

    SetTimer(0.1, false, 'EndDash');
}

function EndDash()
{
    Pawn.SetPhysics(PHYS_Walking);
}

defaultproperties
{
    CameraClass=class'DDCamera'

    // CurrentCameraLocation=(X=512,Z=512)
    // CurrentFocusLocation=(X=0,Z=0)

    CurrentCameraLocation = (Y=-220)

    RotationFactor=0.1f
    MoveSmoothFactor=0.1f

    bManipulatingCam=False

    ChargeSpeed=+200.0

    MinHitWall=0
    bWallWalking=false

    Name="Default__DDBasePlayerController"
}