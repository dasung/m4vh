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

class VHAgent12  extends VHAbstractPawn placeable;

var(NPC) SkeletalMeshComponent NPCMesh;

defaultproperties
{
	s_VHName="peter"
	i_AgentNo=12
  //Setup default NPC mesh
  Begin Object Class=SkeletalMeshComponent Name=NPCMesh12
    SkeletalMesh=SkeletalMesh'Agent12.Agent12'
    PhysicsAsset=PhysicsAsset'Agent1.Agent1_Physics'
    AnimSets(0)=AnimSet'Agent1.Agent1_Anims'
    AnimtreeTemplate=AnimTree'Agent1.Agent1_AnimTree'
  End Object

  NPCMesh=NPCMesh12
  Mesh=NPCMesh12
  Components.Add(NPCMesh12)
	NPCController=class'VHAIController'
}
