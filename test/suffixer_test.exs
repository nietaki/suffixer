defmodule SuffixerTest do
  use ExUnit.Case
  doctest Suffixer

  test "greets the world" do
    assert Suffixer.hello() == :world
  end
end
