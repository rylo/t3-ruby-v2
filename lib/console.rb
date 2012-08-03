module Console
  
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
    output.puts "Please enter a move: "
    get_user_input
  end
  
  def self.put_message(message)
    output.puts message.to_s
  end
  
  def self.set_output(output)
    @output = output
  end
  
end