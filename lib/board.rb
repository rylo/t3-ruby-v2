class Board
  attr_reader :size, :grid, :rows
  
  def initialize(board_size)
    @size = board_size.to_i
    @grid = Array.new
    (@size ** 2).times { @grid << '' }
    generate_playable_rows
  end
  
  def open_spaces
    spaces = []
    grid.each_with_index { |grid_space, index| spaces << index if grid_space == "" }
    spaces
  end
  
  def make_move(marker, destination)
    @grid[destination] = marker
  end
  
  def fetch_grid
    @grid
  end
  
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
      @diagonal_rows = []
      guide.each_with_index {|row, index| @diagonal_rows << row[index]}
      @rows << @diagonal_rows
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
