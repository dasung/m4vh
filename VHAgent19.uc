//*************************************************************************
// PROJECT  :   A Metaphore to Virtual Human Interaction  
// CLASS    :   VHAgent1
// PURPOSE  :   The pawn class for the virtual human - peter
//*************************************************************************
// REVISIONS:
//  Date            Developer		Description
//  ----            ---------		-----------
//  5 Jul 2012	    Dasun Tharaka	Creation
//*************************************************************************

class VHAgent19  extends VHAbstractPawn placeable;

var(NPC) SkeletalMeshComponent NPCMesh;

defaultproperties
{
	s_VHName="peter"
	i_AgentNo=19
  //Setup default NPC mesh
  Begin Object Class=SkeletalMeshComponent Name=NPCMesh19
    SkeletalMesh=SkeletalMesh'Agent19.Agent19'
    PhysicsAsset=PhysicsAsset'Agent1.Agent1_Physics'
    AnimSets(0)=AnimSet'Agent1.Agent1_Anims'
    AnimtreeTemplate=AnimTree'Agent1.Agent1_AnimTree'
  End Object

  NPCMesh=NPCMesh19
  Mesh=NPCMesh19
  Components.Add(NPCMesh19)
	NPCController=class'VHAIController'
}
