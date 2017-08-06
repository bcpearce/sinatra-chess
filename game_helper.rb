def process_move(game, move)

  loc1 = move[0]
  loc2 = move[1]

  unless game.move(loc1, loc2)
    if game.board[loc1].is_a?(Piece) && game.board[loc1].color != game.turn.color
      status = "Invalid move! That is not your piece!"
    else
      error_msg = game.board.move_status.nil? ? "" : game.board.move_status
      status = "Invalid move! " + error_msg
    end
  end


  board = game.board
  player = game.turn

  check =
    if player.king(board).checkmate?(board)
      :checkmate
    elsif player.king(board).check?(board)
      :check
    else
      false
    end

  movelist = game.movelist

  status ||= 'OK'

  return {game:JSON.load(game.to_json), status:status, check:check}.to_json

end