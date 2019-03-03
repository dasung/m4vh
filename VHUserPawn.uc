//*************************************************************************
// PROJECT  :   A Metaphore to Virtual Human Interaction  
// CLASS    :   VHUserPawn
// PURPOSE  :   The pawn for the playercontroller
//*************************************************************************
// REVISIONS:
//  Date            Developer		Description
//  ----            ---------		-----------
//  15 APR 2012	    Dasun Tharaka	Creation
//*************************************************************************
class VHUserPawn extends UTPawn 
  placeable; 

DefaultProperties 
{ 
  Begin Object class=SkeletalMeshComponent Name=SkeletalMeshComponent0 
    SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
				PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
		AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_AimOffset'
		AnimSets(1)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
    bAcceptsLights=true 
    End Object 
  Mesh=SkeletalMeshComponent0 
  Components.Add(SkeletalMeshComponent0) 
	scale=0.65
	BaseEyeHeight=15
	EyeHeight=15
	//ControllerClass=class'UTGame.UTPlayerController.VHPlayerController'
	GroundSpeed=100.0
  //WeaponSocket = PlatformWeapSocket 
 // WeaponSocket2 = PlatformWeapSocket 
}



/*
class VHUserPawn extends GamePawn placeable;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	`Log("Custom Pawn up");
}

simulated function name GetDefaultCameraMode( PlayerController RequestedBy )
{
	`Log("Requested SideScrolling");
    return 'SideScrolling';
}

defaultproperties
{
	Components.Remove(Sprite)
	//MOVEMENT COMPONENTS//
	 GroundSpeed=100.0
	 JumpZ=800.0
	Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		ModShadowFadeoutTime=0.25
		MinTimeBetweenFullUpdates=0.2
		AmbientGlow=(R=.01,G=.01,B=.01,A=1)
		AmbientShadowColor=(R=0.15,G=0.15,B=0.15)
		LightShadowMode=LightShadow_ModulateBetter
		ShadowFilterQuality=SFQ_High
		bSynthesizeSHLight=TRUE
	End Object
	Components.Add(MyLightEnvironment)

    Begin Object Class=SkeletalMeshComponent Name=InitialSkeletalMesh
		CastShadow=true
		bCastDynamicShadow=true
		bOwnerNoSee=false
		LightEnvironment=MyLightEnvironment;
        BlockRigidBody=true;
        CollideActors=true;
        BlockZeroExtent=true;
		PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
		AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_AimOffset'
		AnimSets(1)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
		SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
	End Object

	  Begin Object Name=CollisionCylinder
      CollisionRadius=+0021.000000
      CollisionHeight=+0044.000000
   End Object
   CylinderComponent=CollisionCylinder

	Mesh=InitialSkeletalMesh;
	Components.Add(InitialSkeletalMesh);
}
*/