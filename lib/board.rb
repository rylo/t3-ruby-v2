require 'rules'

class Board
  # storage for moves
  # helpers for board printing ->
  # enforces Rules of Game
  
  
  # INTERFACE:
    # new -> generated correctly
    # set / get moves
    # available moves
    # winning row indexes
  
  attr_reader :size, :grid, :rows
  
  def rules
    Rules.new
  end
  
  def initialize(board_size)
    @size = board_size.to_i
    @grid = Array.new(@size ** 2, '')
    generate_rows
  end
  
  def clear_space(space_number)
    grid[space_number.to_i] = ''
  end
  
  def printable_board
    printed_board = []
    processing_rows = @rows[0..(@size-1)]
    processing_rows.each do |processing_row|
      printed_row = '|'
      processing_row.each { |space| printed_row += @grid[space] + "|" }
      printed_board << printed_row
    end
    printed_board
  end
  
  def open_spaces
    spaces = []
    grid.each_with_index { |grid_space, index| spaces << index unless spot_taken?(index) }
    spaces
  end
  
  def rows_with_open_spaces
    rows_with_open_spaces = []
    open_spaces.each do |open_space|
      rows.each { |row| rows_with_open_spaces << row if row.include?(open_space) }
    end
    rows_with_open_spaces.uniq
  end
  
  def view_row_markers(row)
    row_markers = []
    row.each { |space_number| row_markers << grid[space_number] }
    row_markers
  end
  
  def unique_markers(row)
    view_row_markers(row).uniq.select { |marker| marker != '' }
  end
  
  def ending_move_available?
    ending_move_rows != []
  end
  
  def ending_move_rows
    ending_rows = []
    rows_with_open_spaces.each do |row|
      if unique_markers(row).count == 1
        ending_rows << row if row.select { |space_number| spot_taken?(space_number) }.count == (@size - 1)
      end
    end
    ending_rows
  end
  
  def winning_move_available?(marker)    
    verdict = false
    ending_move_rows.each do |row|    
      if view_row_markers(row).reject{|spot_content| spot_content == ''}.select{|spot| spot == marker}.count == (@size - 1)
        verdict = true
      end
    end
    verdict
  end
  
  def winning_moves(player_marker)
    moves = []
    if winning_move_available?(player_marker)
      ending_move_rows.each do |row|    
        if view_row_markers(row).reject{|spot_content| spot_content == ''}.select{|spot| spot == player_marker}.count == (@size - 1)
          moves << row[view_row_markers(row).rindex('')]
        end
      end
    end
    moves
  end
  
  def spot_taken?(destination)
    @grid[destination] != ""
  end
  
  def set_move(marker, destination)
    destination = destination.to_i
    if rules.valid_move?(self, destination)
      @grid[destination] = marker
    else
      return false
    end
  end
  
  private
  
  def generate_rows
    @rows = []
    @grid_space_numbers = []
    
    grid.each_with_index { |space_number, index| @grid_space_numbers << index }
    
    generate_horizontal_rows
    generate_diagonal_rows
    generate_vertical_rows
  end
  
  def generate_horizontal_rows
    @horizontal_rows = []
    @grid_space_numbers.each_slice(@size) { |grid_space| @horizontal_rows << grid_space }
    @rows += @horizontal_rows
  end
  
  def generate_diagonal_rows
    guides = [@horizontal_rows, @horizontal_rows.reverse]
    
    guides.each do |guide|
      diagonal_rows = []
      guide.each_with_index {|row, index| diagonal_rows << row[index]}
      @rows << diagonal_rows.sort
    end
  end

  def generate_vertical_rows
    row_starting_spaces = @horizontal_rows[0]
    
    row_starting_spaces.each do |starting_space|
      vertical_rows = []
      vertical_rows << starting_space
      (@size-1).times.with_index do |index|
        space = starting_space + (@size*(index+1))
        vertical_rows << @grid_space_numbers[space]
      end
      @rows << vertical_rows
    end
    
    @rows
  end
end
