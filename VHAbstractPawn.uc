//*************************************************************************
// PROJECT  :   A Metaphore to Virtual Human Interaction  
// CLASS    :   VHAbstractPawn
// PURPOSE  :   The abstract pawn class for the virtual humans
//*************************************************************************
// REVISIONS:
//  Date            Developer		Description
//  ----            ---------		-----------
//  5 Jul 2012	    Dasun Tharaka	Creation
//*************************************************************************


class VHAbstractPawn extends UTPawn placeable;
   
var string s_VHName;
var int i_AgentNo;
var(NPC) class<AIController> NPCController; //AI controller for pawns

simulated event PostBeginPlay()
{
  if(NPCController != none)
  {
    //set the existing ControllerClass to our new NPCController class
    ControllerClass = NPCController;
  }
   
  Super.PostBeginPlay();
}

//override to do nothing
simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info)
{
}

function OnTraceHit()
{
	VHAIController(Controller).AnimateHuman();
}

function SelectionByCircle(vector Currpos)
{
	VHAIController(Controller).CircleBasedBehaviorSimulation(Currpos);
}

function SelectionByCone(int ArrAgentsInTheCone[21])
{
	VHAIController(Controller).ConeBasedBehaviorSimulation(ArrAgentsInTheCone);
}


defaultproperties
{
	//SuperHealthMax=300
	GroundSpeed=200.0
}