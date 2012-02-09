//-----------------------------------------------------------
// Base Camera Class - Contains logic to determine which
// camera should be used.
//-----------------------------------------------------------
class DDCamera extends GamePlayerCamera;

protected function GameCameraBase FindBestCameraType(Actor CameraTarget)
{
    //Add here the code that will figure out which cam to use.
    return ThirdPersonCam; // We only have this camera
}

DefaultProperties
{
    ThirdPersonCameraClass=class'DreamDemo.DDThirdPersonCam'
}