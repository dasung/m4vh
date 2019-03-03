//*************************************************************************
// PROJECT  :   A Metaphore to Virtual Human Interaction  
// CLASS    :   VHAgent6
// PURPOSE  :   The pawn class for the virtual human - roshi
//*************************************************************************
// REVISIONS:
//  Date            Developer		Description
//  ----            ---------		-----------
//  5 Jul 2012	    Dasun Tharaka	Creation
//*************************************************************************

class VHAgent6 extends VHAbstractPawn placeable;

var(NPC) SkeletalMeshComponent NPCMesh;

defaultproperties
{
	s_VHName="roshi"
	i_AgentNo=6
  //Setup default NPC mesh
  Begin Object Class=SkeletalMeshComponent Name=NPCMesh6
    SkeletalMesh=SkeletalMesh'Agent6.Agent6'
    PhysicsAsset=PhysicsAsset'Agent1.Agent1_Physics'
    AnimSets(0)=AnimSet'Agent1.Agent1_Anims'
    AnimtreeTemplate=AnimTree'Agent1.Agent1_AnimTree'
  End Object
  NPCMesh=NPCMesh6
  Mesh=NPCMesh6
  Components.Add(NPCMesh6)

  //Points to your custom AIController class - as the default value
		NPCController=class'VHAIController'
}