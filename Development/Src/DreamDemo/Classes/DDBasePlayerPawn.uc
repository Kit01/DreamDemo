/** Base Player Pawn Class **/
class DDBasePlayerPawn extends DDBasePawn;

/* PossessedBy()
 Pawn is possessed by Controller
 Overridden to set initial camera focus location
*/
function PossessedBy(Controller C, bool bVehicleTransition)
{
    local DDBasePlayerController DDBPC;
    super.PossessedBy(C,bVehicleTransition);

    // Cache player controller object
    DDBPC = DDBasePlayerController(C);

    // Set values in controller object where camera should initially be located / point to
    DDBPC.CurrentFocusLocation = self.Location;
    DDBPC.CurrentCameraLocation = self.Location;
    DDBPC.CurrentCameraLocation.Y -= 220.f;
    DDBPC.OriginialCameraOffset = DDBPC.CurrentCameraLocation - self.Location;
}

defaultproperties
{
    Begin Object Name=PawnSkeletalMesh
	   SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
	   AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
	   AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
    End Object

    Begin Object Name=CollisionCylinder
		CollisionRadius=+0021.000000
		CollisionHeight=+0044.000000
	End Object
	CylinderComponent=CollisionCylinder

	AirSpeed=+04000.000000
}