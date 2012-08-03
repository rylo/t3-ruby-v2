class Board
  attr_reader :size, :grid, :rows
  
  def initialize(board_size)
    @size = board_size.to_i
    @grid = Array.new
    (@size ** 2).times { @grid << '' }
    generate_playable_rows
  end
  
  # Take this out of the board class?
  
  def print_board
    printed_board = []
    processing_rows = @rows[0..(@size-1)]
    
    processing_rows.each do |processing_row|
      printed_row = '|'
      processing_row.each { |space| printed_row += @grid[space] + "|" }
      printed_board << printed_row
    end
    
    printed_board.each { |printed_row| Console.put_message(printed_row) }
    printed_board
  end
  
  def open_spaces
    spaces = []
    grid.each_with_index { |grid_space, index| spaces << index if grid_space == "" }
    spaces
  end
  
  def validate_move(destination) 
    if !open_spaces.include?(destination.to_i) || destination.to_i.to_s != destination
      Console.put_message("Invalid move.")
      return "invalid"
    end
  end
  
  def set_move(marker, destination)
    destination = destination.to_i
    @grid[destination] = marker
  end
  
  def fetch_grid
    @grid
  end
  
  # Abstract this out of the board class?
  
  def generate_playable_rows
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
