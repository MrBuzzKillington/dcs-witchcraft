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
