defmodule Conservation do
  def run do
    IO.puts "Incrementing 1"
    IO.puts "  result was => #{Conservation.Server(:server, 1)}" 
    IO.puts "Incrementing 4"
    IO.puts "  result was => #{Conservation.Server(:server, 4)}"
    IO.puts "Incrementing 6"
    IO.puts "  result was => #{Conservation.Server(:server, 6)}"
    IO.puts "Incrementing 7"
    IO.puts "  result was => #{Conservation.Server(:server, 7)}"

    IO.puts "Server's current state:"
    IO.puts "======================="
    IO.inspect :sys.get_state(:server)

    IO.puts "Now let's cause a crash!"
   	Conservation.Server.die :server

	IO.puts "Server's current state:"
    IO.puts "======================="
    IO.inspect :sys.get_state(:server)

   	IO.puts "Same as before crash :-)"
  end
end
