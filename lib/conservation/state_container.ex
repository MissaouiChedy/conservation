defmodule Conservation.StateContainer do
  use GenServer

  def start_link _ do
    GenServer.start_link(__MODULE__, [], name: :container)
  end

  def get pid do
    GenServer.call(pid, :get)
  end

  def set pid, new_state do
    GenServer.cast(pid, {:set, new_state})
  end
  
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:set, new_state}, state) do
    {:noreply, new_state}
  end
  
  def terminate _reason, _state do
    :shutdown    
  end
end