//*************************************************************************
// PROJECT  :   A Metaphore to Virtual Human Interaction  
// CLASS    :   VHAIController
// PURPOSE  :   The AI controller class for each virtual huimans 
//*************************************************************************
// REVISIONS:
//  Date            Developer		Description
//  ----            ---------		-----------
//  5 Jul 2012	    Dasun Tharaka	Creation
//*************************************************************************

class VHAIController extends UTBot;

var Actor o_Destination;
var VHUserPawn o_UserPawn;
var VHAbstractPawn o_AbstractPawn;
var Vector v_ResetLocation;
var float f_CircularRedious; 
var Rotator r_PoseOfHuman;
var bool b_SetAgentReferences;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
}

function UpdateUserPosition()
{
	foreach WorldInfo.AllPawns(class'VHUserPawn',o_UserPawn)
	{
		if(o_UserPawn.IsA('VHUserPawn'))
		{
			break;
		}
	}

	b_SetAgentReferences = True;
}

function AnimateHuman()
{
    `log( "Pawn is being commanded");
	UpdateUserPosition();
	GotoState('doChangingBehavior');
}

function CircleBasedBehaviorSimulation(Vector vPosOfHuman)
{
	
    `log( "Pawn is being commanded");

	if( b_SetAgentReferences == False)
	{
		UpdateUserPosition();
	}

	//Behavioural change of agents who are within 300 units from the selected virtual human 
	foreach OverlappingActors(class'VHAbstractPawn',o_AbstractPawn,f_CircularRedious,vPosOfHuman)
	{
		r_PoseOfHuman = Rotator(o_AbstractPawn.Location - o_UserPawn.Location);
		o_AbstractPawn.SetRotation(r_PoseOfHuman);
	}

	GotoState('doChangingBehavior');
}

function ConeBasedBehaviorSimulation(int ArrAgentsInTheCone[21])
{
    `log( "Pawn is being commanded");

	if( b_SetAgentReferences == False)
	{
		UpdateUserPosition();
	}

	//Behavioural change of agents who are within 300 units from the selected virtual human 
	foreach worldinfo.AllPawns(class'VHAbstractPawn',o_AbstractPawn)
	{
		if(ArrAgentsInTheCone[o_AbstractPawn.i_AgentNo] == 1)
		{
			r_PoseOfHuman = Rotator(o_AbstractPawn.Location - o_UserPawn.Location);
			o_AbstractPawn.SetRotation(r_PoseOfHuman);
		}
	}

	GotoState('doChangingBehavior');
}


state doChangingBehavior
{	
Begin:
	//Warning: o_UserPawn should be checked here.
	v_ResetLocation = o_UserPawn.Location;
	v_ResetLocation.Y = v_ResetLocation.Y - 85;	//Stop human infront of the user

	SetDestinationPosition(v_ResetLocation);
	MoveTo(GetDestinationPosition());
}

state Roaming
{
Begin:
  //If we just began or we have reached the Destination
  //pick a new destination - at random
  if(o_Destination == none || Pawn.ReachedDestination(o_Destination))
  {
    o_Destination = FindRandomDest();
	//Destination = FindPathTowardNearest();	
  }

  //Find a path to the destination and move to the next node in the path

  MoveToward(FindPathToward(o_Destination), FindPathToward(o_Destination));

  //fire off next decision loop
 // LatentWhatToDoNext();
}

DefaultProperties
{
	f_CircularRedious=100
}
