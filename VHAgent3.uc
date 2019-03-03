//*************************************************************************
// PROJECT  :   A Metaphore to Virtual Human Interaction  
// CLASS    :   VHAgent3
// PURPOSE  :   The pawn class for the virtual human - sandra
//*************************************************************************
// REVISIONS:
//  Date            Developer		Description
//  ----            ---------		-----------
//  5 Jul 2012	    Dasun Tharaka	Creation
//*************************************************************************

class VHAgent3 extends VHAbstractPawn placeable;


var(NPC) SkeletalMeshComponent NPCMesh;


defaultproperties
{
	s_VHName="sandra"
	i_AgentNo=3
  //Setup default NPC mesh
  Begin Object Class=SkeletalMeshComponent Name=NPCMesh3
    SkeletalMesh=SkeletalMesh'Agent3.Agent3'
    PhysicsAsset=PhysicsAsset'Agent1.Agent1_Physics'
    AnimSets(0)=AnimSet'Agent1.Agent1_Anims'
    AnimtreeTemplate=AnimTree'Agent1.Agent1_AnimTree'
  End Object
	
  NPCMesh=NPCMesh3
  Mesh=NPCMesh3
  Components.Add(NPCMesh3)

  //Points to your custom AIController class - as the default value
		NPCController=class'VHAIController'
}
