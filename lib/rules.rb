class Rules
  
  def valid_move?(board, destination)
    game_over?(board) || board.spot_taken?(destination.to_i) || destination.to_i.to_s != destination.to_s ? false : true
  end
  
  def game_over?(board)
    won?(board) || draw?(board)
  end
  
  def won?(board)
    verdict = false
    board.rows.each do |row|
      if board.unique_markers(row).count == 1 && board.view_row_markers(row).select { |marker| marker == '' }.count == 0
        verdict = true
      end
    end
    verdict
  end
  
  def draw?(board)
    board.open_spaces.count == 0 && !won?(board)
  end
  
  def won_by?(board, player_marker)
    verdict = false
    board.rows.each do |row|
      verdict = true if board.view_row_markers(row).select{|spot| spot == player_marker}.count == board.size
    end
    verdict
  end
  
end