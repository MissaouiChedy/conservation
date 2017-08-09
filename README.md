# Conservation

A very simple example demonstrating how to achieve GenServer state conservation by using a pair of processes.

<img src="https://raw.githubusercontent.com/MissaouiChedy/conservation/master/diagram.PNG" alt="genservers diagram"/>


The `Server` GenServer allows to increment integers while keeping track of the numbers of increments performed. 

The `StateContainer` GenServer allows `Server` to store and recover its state in the event of a crash.

The `ProcSupervisor` supervises the execution of the two previous GenServers.

## Running the example

By opening an `iex` session by issuing an `iex -S mix` and running the `Conservation.run` function you can see the following explanatory output:
```
iex(1)> Incrementing 1
  result was => 2

Incrementing 4
  result was => 5

Incrementing 6
  result was => 7

Incrementing 7
  result was => 8

Server's current state:
=======================
{4, :container}

Now let's cause a crash!

Server's current state:
=======================
{4, :container}

Same as before crash :-)
:ok
iex(2)> 
09:45:22.546 [error] GenServer :server terminating
** (ArithmeticError) bad argument in arithmetic expression (omitted output...)
```



#### N.B
- Use the `Conservation.Server.increment/2` function to increment an integer

- Use the `Conservation.Server.die/1` function to cause the GenServer to crash

- Try inspecting `Server`'s state via `:sys.get_state` for example to see how the state is conserved between crashes

The application launches named GenServers having the following names:
 - `Conservation.Server => :server`
 - `Conservation.StateContainer => :container`


