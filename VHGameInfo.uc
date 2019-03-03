//*************************************************************************
// PROJECT  :   A Metaphore to Virtual Human Interaction  
// CLASS    :   VHGameInfo
// PURPOSE  :   All the game rules are handled by this class
//*************************************************************************
// REVISIONS:
//  Date            Developer		Description
//  ----            ---------		-----------
//  15 APR 2012	    Dasun Tharaka	Creation
//*************************************************************************

class VHGameInfo extends Gameinfo;

//change the player name to 'VH'
event PlayerController Login(string Portal, string Options, const UniqueNetID UniqueID, out string ErrorMessage)
{
	local PlayerController PC;

	PC = super.Login(Portal, Options, UniqueID, ErrorMessage);

	//if(PC.Pawn == None)
	//{
	//	PC.Possess(Spawn(class'CluOneUserPawn'),False);
	//}
	
	ChangeName(PC, "VH-Metaphor Evaluator", true);
    return PC;
}

//Welcome player after join
event PostLogin( PlayerController NewPlayer )
{
    super.PostLogin(NewPlayer);
	NewPlayer.ClientMessage("Welcome to the research prototype: Please pay attention to assessor");
	NewPlayer.ClientMessage("! Make sure you have understood the given intruction by the assessor");
    NewPlayer.ClientMessage("The grid "$NewPlayer.PlayerReplicationInfo.PlayerName);
}

defaultproperties
{
	bRestartLevel=False
    PlayerControllerClass=class'VHPlayerController'
	DefaultPawnClass=class'VHUserPawn'
	bDelayedStart=false //If you don't set this to false, the player will be stuck
	Name="VHGameInfo"
}
