class UI
  
  def self.set_output(output)
    @output = output
  end
  
  def self.set_input(input)
    @input = input
  end

end


class ConsoleUI < UI
    
  def self.input
    @input ||= STDIN
  end
  
  def self.output
    @output ||= STDOUT
  end
  
  def self.get_user_input
    input.gets.chomp
  end
  
  def self.ask_for_input
    put_message("Please enter a move: ")
    get_user_input
  end
  
  def self.ask_for_first_player
    put_message("Who goes first?")
    get_user_input
  end
  
  def self.put_message(message)
    if message.class == String
      output.puts message.to_s
    elsif message.class == Array || message.class == Hash
      message.each { |line| output.puts line }
    end
  end
  
end