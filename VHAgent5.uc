//*************************************************************************
// PROJECT  :   A Metaphore to Virtual Human Interaction  
// CLASS    :   VHAgent5
// PURPOSE  :   The pawn class for the virtual human - kathie
//*************************************************************************
// REVISIONS:
//  Date            Developer		Description
//  ----            ---------		-----------
//  5 Jul 2012	    Dasun Tharaka	Creation
//*************************************************************************

class VHAgent5 extends VHAbstractPawn placeable;

var(NPC) SkeletalMeshComponent NPCMesh;


defaultproperties
{
	s_VHName="kathie"
	i_AgentNo=5
  //Setup default NPC mesh
  Begin Object Class=SkeletalMeshComponent Name=NPCMesh5
    SkeletalMesh=SkeletalMesh'Agent5.Agent5'
    PhysicsAsset=PhysicsAsset'Agent1.Agent1_Physics'
    AnimSets(0)=AnimSet'Agent1.Agent1_Anims'
    AnimtreeTemplate=AnimTree'Agent1.Agent1_AnimTree'
  End Object
  NPCMesh=NPCMesh5
  Mesh=NPCMesh5
  Components.Add(NPCMesh5)

  //Points to your custom AIController class - as the default value
		NPCController=class'VHAIController'
}
