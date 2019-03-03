# m4vh
//****************************************************************************
// University of Colombo School of Computing, Colombo, Sri Lanka - 2012
// PROJECT    :   A Metaphore to Virtual Human Interaction  
// Developer  :   Dasun Tharaka Gunasekara
// Supervisor :   Dr.Prasad Wimalarathne
// Perpose    :   This is the implementation of our research prototype.
				  The technical details of implemntation, version controlling 
				  detaild are listed as bellow.
//****************************************************************************
// Revision and features added

20 APR 2012 - Protytpe v1.0
----------------------------
1- Intitial player controller systems
2- Simple out door scence in level creation


12 MAY 2012 - Protytpe v1.1
----------------------------
1- Skelean human modules with animation were added to the system
2- Animation interaction with user's mouse click event


22 JUN 2012 - Protytpe v1.2
----------------------------
1- The microsoft voice recognition module integrated with simulation
2- User's voice commands are interpret at the frontend using DLL bindings


30 JUN 2012 - Protytpe v1.5
----------------------------
1- Added seperate AI controller for virtual human animation  


11 JUN 2012 - Protytpe v2.0
----------------------------
1- A seperate player for controlling users
2- Added Ray casting metaphor
3- Added Voice Ray casting metaphor
4- Added Direct voice selection metaphor

20 JUL 2012 - Protytpe v2.0001
----------------------------
Remove Pawn class due to unmanageble cercumstances 

20 JUL 2012 - Protytpe v2.1
----------------------------
Woohoo...! problem soloved
- Integrated pawn class again
- Now protype fully functional with 1st person point of view
- Feature added - now ray casting by getting the player's view point using GetPlayerViewPoint()

21 JUL 2012 - Protytpe v2.2
----------------------------

- Add AI navigation to the pawns
- Implementation of the behavioral controller 
- Add rotation animation for nearby humans (Social interaction of selection)

1 AUG 2012 - Protytpe v2.5
----------------------------

-Final version of the prototype
------------Features------------

-self controlable 20 agent platform
-unique parameters for each agents (color)
-Ray cast selection
-Voice-Ray casting selection
-Voice casting feature
-Accurate selection (motivated by an improved virtual pointer metaphor)
-Circle based behavioral control modale
-Cone based behavioral control modale
-Configurable radius of the circle 
-Configurable width of the cone
-allow exec commands at runtime in the simulation 

