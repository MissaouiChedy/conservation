defmodule Conservation do
  def run do
    IO.puts "Incrementing 1"
    IO.puts "  result was => #{Conservation.Server.increment(:server, 1)}" 
    IO.puts "" 
    
    IO.puts "Incrementing 4"
    IO.puts "  result was => #{Conservation.Server.increment(:server, 4)}"
    IO.puts "" 
    
    IO.puts "Incrementing 6"
    IO.puts "  result was => #{Conservation.Server.increment(:server, 6)}"
    IO.puts "" 
    
    IO.puts "Incrementing 7"
    IO.puts "  result was => #{Conservation.Server.increment(:server, 7)}"
    IO.puts "" 

    IO.puts "Server's current state:"
    IO.puts "======================="
    IO.inspect :sys.get_state(:server)

    IO.puts "" 
    IO.puts "Now let's cause a crash!"
    IO.puts "" 
    try do
      Conservation.Server.die(:server)
    catch
      :exit, _ -> IO.puts "Server's current state:"
           IO.puts "======================="
           IO.inspect :sys.get_state(:server)
           IO.puts "" 
           IO.puts "Same as before crash :-)"
    end
  end
end
