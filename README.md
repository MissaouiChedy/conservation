# Conservation

A very simple example demonstrating how to achieve GenServer state conservation by using a pair of processes.


The `Server` GenServer allows to increment integers while keeping track of the numbers of increments performed. 

The `StateContainer` GenServer allows `Server` to store and recover its state in the event of a crash.

The `ProcSupervisor` supervises the execution of the two previous GenServers.

## Running the example

By opening an `iex` session by issuing an `iex -S mix` and running the `Conservation.run` function you can see the following explanatory output:




#### N.B
- Use the `Conservation.Server.increment/2` function to increment an integer

- Use the `Conservation.Server.die/1` function to cause the GenServer to crash

- Try inspecting `Server`'s state via `:sys.get_state` for example to see how the state is conserved between crashes

The application launches named GenServers having the following names:
 - `Conservation.Server => :server`
 - `Conservation.StateContainer => :container`


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `conservation` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:conservation, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/conservation](https://hexdocs.pm/conservation).

