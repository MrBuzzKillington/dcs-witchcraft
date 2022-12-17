dcs-witchcraft
==============

"DCS Witchcraft" is:
* a node.js server application
* a Lua script that runs in the DCS: World mission scripting environment and talks to the node.js server via a TCP connection
* some web applications, including a debug console that allows you to execute Lua snippets inside the running mission and look at the return values

Here's what works so far:
* Lua debug console for interactive development and debugging of mission scripts
* Mission Editor to adjust the positions of existing units (mirrored to the running mission so you can watch the final position in the 3D environment)

[Watch the video walkthrough](http://www.dailymotion.com/video/x21d3ac_dcs-witchcraft-tutorial_videogames) to learn more.

## Initial Setup
* Copy `witchcraft.lua` to `%USERPROFILE%\Saved Games\DCS\Scripts\` (e.g. `C:\Users\<Your Username>\Saved Games\DCS\Scripts\`).
* Go to your DCS: World installation directory (most likely `C:\Program Files\Eagle Dynamics\DCS World`), open the `Scripts` subfolder and edit the file `MissionScripting.lua`.
Add the following code somewhere before the function `sanitizeModule` is defined:
````lua
witchcraft = {}
witchcraft.host = "localhost"
witchcraft.port = 3001
dofile(lfs.writedir()..[[Scripts\witchcraft.lua]])
````

## Preparing the Mission
To start trying to connect to the node.js server, your mission will have to call `witchcraft.start(_G)`.

Create a new trigger set to fire ONCE, create a new condition TIME IS MORE (1 second) and add two actions:

1. a DO SCRIPT FILE action that loads [MIST](http://forums.eagle.ru/showthread.php?t=98616). Make sure you are using **MIST 3.3 or later!**
2. a DO SCRIPT action with the text `witchcraft.start(_G)`

## Using the Debug Console and the Map
* Start the node.js server. If you are using windows, simply double-click `witchcraft.cmd` in the `windows` subfolder of this repository.
* Start your DCS: World mission and enter a slot (singleplayer) or unpause the server (multiplayer).
* Point a web browser at http://localhost:3000 (if you used witchcraft.cmd, it automatically did that for you in the first step).

The Lua debug console is mostly self-explanatory. Just play around with it and avoid infinite loops (those will understandably cause DCS to hang).

If you want the map to display the live positions of ground units, you have to tell witchcraft that it should send regular unit updates (select the "enable unit updates" template in the Lua Console and press Ctrl+Enter to execute it).
The map is in an early stage and is currently hard-coded to only show units of the blue coalition.


## License
The project itself is licensed under the GPLv3 or later. For third-party components (node.js and npm modules, the map icons, anything under `src/bower_components` and `src/vendor_js`), the licensing information can be found in the respective subdirectories or in the source file itself.

##Notes from BuzzKillington
I had to modify the node.js to support the latest version of JS from microsoft. It appears the commands for network stuff changed, you can see
the change log for details.  I also had to do these things to get it to work in window10, they are outlined in the witchcraft.cmd script as well

cd ..\src
rem call ..\windows\nodejs\npm.cmd --spin=false --loglevel=info install
rem ..\windows\nodejs\node backend\server.js
call C:\"Program Files"\nodejs\npm.cmd --spin=false --loglevel=info install
C:\"Program Files"\nodejs\node backend\server.js
rem start http://localhost:3000/
pause
REM had to run install as admin to get the packages.
rem npm init
rem then the install
rem then npm.cmd install network.io
rem edited the file var io = require('socket.io')(port,"0.0.0.0");


Once you have this running you should get a terminal that says waiting for dcs.  You need to add the withcraftExport.lua to the scripts folder and add it to your 
dofile(lfs.writedir()..[[Scripts\WitchcraftExport.lua]])

exports or else you will get error like "[string "1671248087514"]:2: attempt to call global 'list_indication' (a nil value) when you try to do anything

##running notes
So you ahve the terminal running, you start DCS and get into a  plane.  You should see DCS connected message.
Now in a web browser goto http://localhost:3000/console.html#

From this terminal you can issue lua commands directly into running DCS.
I use this to diagnose DCSbios. Basicly you can issue direct bio calls (Copy in the function calls) or read out other things

Try this "return list_indication(6)"
On F16 you will get the current DED text!!

Hope this helps!