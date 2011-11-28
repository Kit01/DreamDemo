/** Base Pawn Class **/
class DDBasePawn extends UDKPawn;

defaultproperties
{
    Begin Object class=SkeletalMeshComponent Name=PawnSkeletalMesh
	   HiddenGame=FALSE
	   HiddenEditor=FALSE
       End Object
       Mesh=PawnSkeletalMesh
    Components.Add(PawnSkeletalMesh)
}