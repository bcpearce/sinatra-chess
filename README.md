# Sinatra Chess

This project uses the libraries developed in "Command Line Chess" to bring chess to life on the Web using the Sinatra DSL.

See this project in action at http://chess.bcpearce.com

## Launching

Install necessary Gemfiles using bundler.
```
$ bundle install
```
After installation of required libraries, run 
```
$ rackup
```
to launch the application. 

### React Chess

If you are using this application with [Chess React](https://github.com/bcpearce/chess-react), you must launch the application on the 'stateless' branch.

## Making Moves

Moves can be made by clicking a piece and selecting a square to move it to. Selecting the original square will deselect that piece and allow selecting another piece.  

Make a Castling move by placing the king in its "after-castling" position.  For example, if white were to make a king-side castle, it would move the King from "E1" to "G1".

## Chess Libraries

This project uses the chess libraries at https://github.com/Hawkeye000/command-line-chess.

## Coming Soon...

Add Chess Clock feature.
Add move history.  
