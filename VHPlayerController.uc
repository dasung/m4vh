//*************************************************************************
// PROJECT  :   A Metaphore to Virtual Human Interaction  
// CLASS    :   VHPlayerController
// PURPOSE  :   The brain of the player
//*************************************************************************
// REVISIONS:
//  Date            Developer		Description
//  ----            ---------		-----------
//  15 APR 2012	    Dasun Tharaka	Creation
//*************************************************************************													////////////////////////

class VHPlayerController extends UTPlayerController  DLLBind(SpeechBuilder);


//Initializing voice recognition module
var string s_Command;
var bool b_IsActivate; 
var bool b_SetAgentReferences;
var bool b_AccurateSelection;
var bool b_ConeBaseSimulation;
var bool b_CircleBaseSimulation;
var int iArr_AgentsInTheCone[21];
var float f_ConeWidth;
var VHAbstractPawn o_AbstractPawn;
var VHAgent1 o_Agent1;
var VHAgent2 o_Agent2;
var VHAgent3 o_Agent3;
var VHAgent4 o_Agent4;
var VHAgent5 o_Agent5;
var VHAgent6 o_Agent6;
var VHAgent7 o_Agent7;
var VHAgent8 o_Agent8;
var VHAgent9 o_Agent9;
var VHAgent10 o_Agent10;
var VHAgent11 o_Agent11;
var VHAgent12 o_Agent12;
var VHAgent13 o_Agent13;
var VHAgent14 o_Agent14;
var VHAgent15 o_Agent15;
var VHAgent16 o_Agent16;
var VHAgent17 o_Agent17;
var VHAgent18 o_Agent18;
var VHAgent19 o_Agent19;
var VHAgent20 o_Agent20;
//DLL Caling stucts
struct MyPlayerStruct
{
	var string PlayerName;
	var string PlayerPassword;
	var float Health;
	var float Score;
};

dllimport final function ActivateVoice();
dllimport final function string GetVoiceCommand();
dllimport final function ShowPlayerInfo(MyPlayerStruct PlayerStruct);
dllimport final function string UpdatePassword(out MyPlayerStruct PlayerStruct, string NewPassword);

//Set timer function
event Timer()
{
	`log("Timer wake up");
	VoiceRayCasting();
}


event PostBeginPlay()
{
    SetTimer(1.0, true); // trigger every 1.0 seconds, continuously	
	SetAgentReferences();
}	
//////////////////////////////
function SetAgentReferences()
{
	foreach WorldInfo.AllPawns(class'VHAbstractPawn',o_AbstractPawn)
	{
		if(o_AbstractPawn.IsA('VHAgent1'))
		{
			o_Agent1 = VHAgent1(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent2'))
		{
			o_Agent2 = VHAgent2(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent3'))
		{
			o_Agent3 = VHAgent3(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent4'))
		{
			o_Agent4 = VHAgent4(o_AbstractPawn);
		}

		else if(o_AbstractPawn.IsA('VHAgent5'))
		{
			o_Agent5 = VHAgent5(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent6'))
		{
			o_Agent6 = VHAgent6(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent7'))
		{
			o_Agent7 = VHAgent7(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent8'))
		{
			o_Agent8 = VHAgent8(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent9'))
		{
			o_Agent9 = VHAgent9(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent10'))
		{
			o_Agent10 = VHAgent10(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent11'))
		{
			o_Agent11 = VHAgent11(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent12'))
		{
			o_Agent12 = VHAgent12(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent13'))
		{
			o_Agent13 = VHAgent13(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent14'))
		{
			o_Agent14 = VHAgent14(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent15'))
		{
			o_Agent15 = VHAgent15(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent16'))
		{
			o_Agent16 = VHAgent16(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent17'))
		{
			o_Agent17 = VHAgent17(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent18'))
		{
			o_Agent18 = VHAgent18(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent19'))
		{
			o_Agent19 = VHAgent19(o_AbstractPawn);
		}
		else if(o_AbstractPawn.IsA('VHAgent20'))
		{
			o_Agent20 = VHAgent20(o_AbstractPawn);
		}
		else
		{}
	}

	b_SetAgentReferences = True;
}
///////////////////////

//Draw a crosshair. 

function DrawHUD( HUD H )
{
	local float CrosshairSize;
	super.DrawHUD(H);

	H.Canvas.SetDrawColor(0,255,0,255);

	CrosshairSize = 4;

	H.Canvas.SetPos(H.CenterX - CrosshairSize, H.CenterY);
	H.Canvas.DrawRect(2*CrosshairSize + 1, 1);

	H.Canvas.SetPos(H.CenterX, H.CenterY - CrosshairSize);
	H.Canvas.DrawRect(1, 2*CrosshairSize + 1);
}

auto state PlayerWalking
{

	exec function StartFire( optional byte FireModeNum )
	{
		local float fTimer1;
		Clock(fTimer1);
		RayCast();   //Call ray casting metaphore 
		Unclock(fTimer1);
		ClientMessage("Elapsed time for ray casting: " $fTimer1$ "ms");
	}

	exec function StartAltFire (optional byte FireModeNum)
	{
		ActivateVoice();
		b_IsActivate = true; 
	}
}

function AgentBasedSimulation(VHAbstractPawn o_selected)
{
			if(b_CircleBaseSimulation == true)
				o_selected.SelectionByCircle(o_selected.Location);
			else if(b_ConeBaseSimulation == true)
				o_selected.SelectionByCone(iArr_AgentsInTheCone);
			else
				o_selected.OnTraceHit();
}

//Ray Casting metaphore

function RayCast()
{
	local vector loc, norm;
	local TraceHitInfo hitInfo;
	local Actor traceHit;

	local vector TraceDistance;
    local vector LookDistance;
    local Rotator ViewRotation;
    local Vector ViewLocation;

	local int iAgentIdOfMinDist;
	local float fMinDist;
	local float fCurrentMinDust;
	local int iCurrentAgent;
	local vector vPosToFindDist;


	GetPlayerViewPoint(ViewLocation, ViewRotation);
    LookDistance = vector(ViewRotation) * 5000;
	TraceDistance = ViewLocation + LookDistance;

	//ckeck object pool
	if(b_SetAgentReferences == False)
	{
		`log( "VHPlayerController: something is gettng wrong");
		return;
	}

	fMinDist=2000.0;
	//Distance calculation 
	for( iCurrentAgent=1; iCurrentAgent<21;iCurrentAgent++)
	{
		if(iCurrentAgent == 1)
		{
			vPosToFindDist =  o_Agent1.Location;
		}
		else if(iCurrentAgent == 2)
		{
			vPosToFindDist =  o_Agent2.Location;
		}
		else if(iCurrentAgent == 3)
		{
			vPosToFindDist =  o_Agent3.Location;
		}
		else if(iCurrentAgent == 4)
		{
			vPosToFindDist =  o_Agent4.Location;
		}
		else if(iCurrentAgent == 5)
		{
			vPosToFindDist =  o_Agent5.Location;
		}
		else if(iCurrentAgent == 6)
		{
			vPosToFindDist =  o_Agent6.Location;
		}
		else if(iCurrentAgent == 7)
		{
			vPosToFindDist =  o_Agent7.Location;
		}
		else if(iCurrentAgent == 8)
		{
			vPosToFindDist =  o_Agent8.Location;
		}
		else if(iCurrentAgent == 9)
		{
			vPosToFindDist =  o_Agent9.Location;
		}
		else if(iCurrentAgent == 10)
		{
			vPosToFindDist =  o_Agent10.Location;
		}
		else if(iCurrentAgent == 11)
		{
			vPosToFindDist =  o_Agent11.Location;
		}
		else if(iCurrentAgent == 12)
		{
			vPosToFindDist =  o_Agent12.Location;
		}
		else if(iCurrentAgent == 13)
		{
			vPosToFindDist =  o_Agent13.Location;
		}
		else if(iCurrentAgent == 14)
		{
			vPosToFindDist =  o_Agent14.Location;
		}
		else if(iCurrentAgent == 15)
		{
			vPosToFindDist =  o_Agent15.Location;
		}
		else if(iCurrentAgent == 16)
		{
			vPosToFindDist =  o_Agent16.Location;
		}
		else if(iCurrentAgent == 17)
		{
			vPosToFindDist =  o_Agent17.Location;
		}
		else if(iCurrentAgent == 18)
		{
			vPosToFindDist =  o_Agent18.Location;
		}
		else if(iCurrentAgent == 19)
		{
			vPosToFindDist =  o_Agent19.Location;
		}
		else if(iCurrentAgent == 20)
		{
			vPosToFindDist =  o_Agent20.Location;
		}
		else{}

		fCurrentMinDust = PointDistToLine(vPosToFindDist, vector(ViewRotation), ViewLocation);
			
		if(fCurrentMinDust <f_ConeWidth)
		{
			iArr_AgentsInTheCone[iCurrentAgent] = 1;
		}
		else
		{
			iArr_AgentsInTheCone[iCurrentAgent] = 0;
		}

		if(fMinDist > fCurrentMinDust)
		{
			iAgentIdOfMinDist = iCurrentAgent;
			fMinDist = fCurrentMinDust;
		}
	}//end for

	//Globle ray casting function
    traceHit = Trace(loc, norm, TraceDistance, ViewLocation, true,, hitInfo);
	/////////////////////////////////////////////////////////////////////////

	if (traceHit.IsA('VHAbstractPawn'))
	{
		AgentBasedSimulation(VHAbstractPawn(traceHit));
	}
	else if(b_AccurateSelection == true)
	{//Improved accuracy of the ray casting mrtaphor 

		if(iAgentIdOfMinDist == 1)
		{
			AgentBasedSimulation(o_Agent1);
		}
		else if(iAgentIdOfMinDist == 2)
		{
			AgentBasedSimulation(o_Agent2);
		}
		else if(iAgentIdOfMinDist == 3)
		{
			AgentBasedSimulation(o_Agent3);
		}
		else if(iAgentIdOfMinDist == 4)
		{
			AgentBasedSimulation(o_Agent4);
		}
		else if(iAgentIdOfMinDist == 5)
		{
			AgentBasedSimulation(o_Agent5);
		}
		else if(iAgentIdOfMinDist == 6)
		{
			AgentBasedSimulation(o_Agent6);
		}
		else if(iAgentIdOfMinDist == 7)
		{
			AgentBasedSimulation(o_Agent7);
		}
		else if(iAgentIdOfMinDist == 8)
		{
			AgentBasedSimulation(o_Agent8);
		}
		else if(iAgentIdOfMinDist == 9)
		{
			AgentBasedSimulation(o_Agent9);
		}
		else if(iAgentIdOfMinDist == 10)
		{
			AgentBasedSimulation(o_Agent10);
		}
		else if(iAgentIdOfMinDist == 11)
		{
			AgentBasedSimulation(o_Agent11);
		}
		else if(iAgentIdOfMinDist == 12)
		{
			AgentBasedSimulation(o_Agent12);
		}
		else if(iAgentIdOfMinDist == 13)
		{
			AgentBasedSimulation(o_Agent13);
		}
		else if(iAgentIdOfMinDist == 14)
		{
			AgentBasedSimulation(o_Agent14);
		}
		else if(iAgentIdOfMinDist == 15)
		{
			AgentBasedSimulation(o_Agent15);
		}
		else if(iAgentIdOfMinDist == 16)
		{
			AgentBasedSimulation(o_Agent16);
		}
		else if(iAgentIdOfMinDist == 17)
		{
			AgentBasedSimulation(o_Agent17);
		}
		else if(iAgentIdOfMinDist == 18)
		{
			AgentBasedSimulation(o_Agent18);
		}
		else if(iAgentIdOfMinDist == 19)
		{
			AgentBasedSimulation(o_Agent19);
		}
		else if(iAgentIdOfMinDist == 20)
		{
			AgentBasedSimulation(o_Agent20);
		}
		else{}
	}
	else{}
}//end RayCast()

//Voice-Ray Casting metaphore

function VoiceRayCasting()
{
	local float fTimer2, fTimer3;
	if(b_IsActivate)
	{
		Clock(fTimer2);
		Clock(fTimer3);
		s_Command = GetVoiceCommand();	
	
		if(s_Command == "generic")
		{
			RayCast();
			ClientMessage(s_Command);	
			s_Command = "NULL";
			UnClock(fTimer2);
			ClientMessage("Elapsed time for voice-ray casting: " $fTimer2$ "ms");
			UnClock(fTimer3);
		}
		else if(s_Command != "NULL")
		{
			b_ConeBaseSimulation = false; //Here I need to disable cone based simulation
			VoiceCasting();
			s_Command = "NULL";
			UnClock(fTimer3);
			ClientMessage("Elapsed time for voice casting: " $fTimer3$ "ms");
			UnClock(fTimer2);
		}
		else
		{
			UnClock(fTimer2);
			UnClock(fTimer3);
		}

	}
}

//voice-selection metaphore

function VoiceCasting()
{
	/*Note: Remove Dynamic array due to perfomance hit
	Local VHAbstractPawn TempVH;
	foreach DynamicActors(class'VHAbstractPawn',TempVH)
	{}
	*/
	if(s_Command == "blackman")
	{
		AgentBasedSimulation(o_Agent1);
		ClientMessage("Blackman selected");
	}
    else if(s_Command == "whiteman")
    {
		AgentBasedSimulation(o_Agent2);
		ClientMessage("Whiteman selected");
	}
	else if(s_Command == "orangeman")
	{
		AgentBasedSimulation(o_Agent3);
		ClientMessage("Orangeman selected");
	}
	else if(s_Command == "redman")
	{
		AgentBasedSimulation(o_Agent4);
		ClientMessage("Redman selected");
	}
	    else if(s_Command == "blueman")
    {
		AgentBasedSimulation(o_Agent5);
		ClientMessage("Blueman selected");
	}
	else if(s_Command == "greenman")
	{
		AgentBasedSimulation(o_Agent6);
		ClientMessage("Greenman selected");
	}
	else if(s_Command == "pinkman")
	{
		AgentBasedSimulation(o_Agent7);
		ClientMessage("Pinkman selected");
	}
    else if(s_Command == "yellowman")
    {
		AgentBasedSimulation(o_Agent8);
		ClientMessage("Yellowman selected");
	}
	else if(s_Command == "ashman")
	{
		AgentBasedSimulation(o_Agent9);
		ClientMessage("Ashman selected");
	}
	else if(s_Command == "brownman")
	{
		AgentBasedSimulation(o_Agent10);
		ClientMessage("Brownman selected");
	}
	else if(s_Command == "brownwoman")
    {
		AgentBasedSimulation(o_Agent11);
		ClientMessage("Brownwoman selected");
	}
	else if(s_Command == "blackwoman")
	{
		AgentBasedSimulation(o_Agent12);
		ClientMessage("Blackwoman selected");
	}
	else if(s_Command == "ashwoman")
	{
		AgentBasedSimulation(o_Agent13);
		ClientMessage("Ashwoman selected");
	}
	else if(s_Command == "redwoman")
    {
		AgentBasedSimulation(o_Agent14);
		ClientMessage("Redwoman selected");
	}
	else if(s_Command == "orangewoman")
	{
		AgentBasedSimulation(o_Agent15);
		ClientMessage("Orangewoman selected");
	}
	else if(s_Command == "bluewoman")
	{
		AgentBasedSimulation(o_Agent16);
		ClientMessage("Bluewoman selected");
	}
	else if(s_Command == "greenwoman")
	{
		AgentBasedSimulation(o_Agent17);
		ClientMessage("Greenwoman selected");
	}
	else if(s_Command == "pinkwoman")
    {
		AgentBasedSimulation(o_Agent18);
		ClientMessage("Pinkwoman selected");
	}
	else if(s_Command == "yellowwoman")
	{
		AgentBasedSimulation(o_Agent19);
		ClientMessage("Yellowwoman selected");
	}
	else if(s_Command == "whitewoman")
	{
		AgentBasedSimulation(o_Agent20);
		ClientMessage("Whitewoman selected");
	}
	else
	{}
}

exec function SetAccuracy(bool bDo)
{
	b_AccurateSelection=bDo;
	b_ConeBaseSimulation=false;
	b_CircleBaseSimulation=false;
}

exec function SetVoiceCasting(bool bDo)
{
	b_IsActivate = bDo;
}

exec function SetConeBasedSimulation(bool bDo)
{
	b_ConeBaseSimulation=bDo;
	b_CircleBaseSimulation=false;
}

exec function SetCircleBaseSimulation(bool bDo)
{
	b_CircleBaseSimulation=bDo;
	b_ConeBaseSimulation=false;
}

exec function SetCircleRadius(float fRegion)
{
	local VHAIController oController;
	foreach WorldInfo.AllControllers(class'VHAIController', oController)
	{
		if(oController.IsA('VHAIController'))
		{
			oController.f_CircularRedious=fRegion;
		}
	}
}

exec function SetConeWidth(float fWidth)
{
	f_ConeWidth = fWidth;
}

exec function ShowCommands()
{
		ClientMessage("-----Syntax for voice based selection-----");
		ClientMessage("COLOR + MAN = Blackman");
		ClientMessage("The man in + COLOR + jacket = The man in color blsck jacket");
		ClientMessage("COLOR + WOMAN = Blackwoman");
		ClientMessage("The woman in + COLOR + bloves = The woman in black bloves");
}

defaultproperties
{	
	bBehindView=false //set camara behind the player
	b_SetAgentReferences=false
	b_AccurateSelection=false
	b_ConeBaseSimulation=false;
	b_CircleBaseSimulation=false
	f_ConeWidth=150;
	bForceBehindView=false //we get a third-person camera instead of a first-person camera
	bMouseControlEnabled=true
}
