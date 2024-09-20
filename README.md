# README
## About
This is a small app to create PDF Sodoku puzzles and Answer keys.

## Requirements
This was written on OSX 14 (Sonoma) and XCode 16, so those are the practical requirements to build and run this app (nothing else has been tested)

## Using
Currently this app freezes a lot, so running in XCode is recomended. So you can stop the app (force kill should also work here)
Hit "Create" button, if it does not show in a few seconds (less than 5 on my machine) then it is probably frozen.
Hit "Save" and two PDF files will be written:

the Save count is set to 0 at app start, then incremented every time "Save" is pressed.

<FileName>_<SaveCount>_puzzle.pdf
<FileName>_<SaveCount>_solved.pdf

Many thanks to: https://github.com/alexehrlich
I lifted their Backtracing solver pretty much verbatim: https://github.com/alexehrlich/Backtracking-Sodoku-Solver-Swift
