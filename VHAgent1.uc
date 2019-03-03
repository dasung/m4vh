//*************************************************************************
// PROJECT  :   A Metaphore to Virtual Human Interaction  
// CLASS    :   VHAgent1
// PURPOSE  :   The pawn class for the virtual human 
//*************************************************************************
// REVISIONS:
//  Date            Developer		Description
//  ----            ---------		-----------
//  5 Jul 2012	    Dasun Tharaka	Creation
//*************************************************************************

class VHAgent1  extends VHAbstractPawn placeable;

var(NPC) SkeletalMeshComponent NPCMesh;

defaultproperties
{
	s_VHName="peter"
	i_AgentNo=1
  //Setup default NPC mesh
  Begin Object Class=SkeletalMeshComponent Name=NPCMesh1
    SkeletalMesh=SkeletalMesh'Agent1.Agent1'
    PhysicsAsset=PhysicsAsset'Agent1.Agent1_Physics'
    AnimSets(0)=AnimSet'Agent1.Agent1_Anims'
    AnimtreeTemplate=AnimTree'Agent1.Agent1_AnimTree'
  End Object

  NPCMesh=NPCMesh1
  Mesh=NPCMesh1
  Components.Add(NPCMesh1)
	NPCController=class'VHAIController'
}
