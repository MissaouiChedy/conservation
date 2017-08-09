defmodule ConservationTest do
  use ExUnit.Case
  doctest Conservation

  test "greets the world" do
    assert Conservation.hello() == :world
  end
end
