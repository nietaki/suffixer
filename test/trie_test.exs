defmodule TrieTest do
  use ExUnit.Case

  alias Trie

  test "new() returns a sane node" do
    assert %Trie{children: %{}, value: nil} == Trie.new()
    assert %Trie{children: %{}, value: nil} == Trie.new(nil)
    assert %Trie{children: %{}, value: :foo} == Trie.new(:foo)
  end

  test "get() on an empty node" do
    n = Trie.new()
    assert :foo == Trie.get(n, 'a', :foo)
    assert nil == Trie.get(n, 'a')
  end

  test "put" do
    n = Trie.new(:foo)
    n2 = Trie.put(n, 'z', Trie.new(:bar))

    assert :foo == n2.value
    assert Trie.new(:bar) == Trie.get(n2, 'z')
    assert nil == Trie.get(n2, 'x')
  end

  test "insert" do
    trie =
      Trie.new()
      |> Trie.insert("abc", :abc)
      |> Trie.insert("add", :add)

    assert (trie.children |> Map.keys()) == [?a]
    assert (trie.children[?a].children |> Map.keys() |> Enum.sort()) == 'bd'
  end

  test "lookup_value" do
    trie =
      Trie.new()
      |> Trie.insert("abc", :abc)
      |> Trie.insert("add", :add)
      |> Trie.insert("zapped", :zapped)

    assert Trie.lookup_value(trie, "abc") == :abc
    assert Trie.lookup_value(trie, "add") == :add
    assert Trie.lookup_value(trie, "zapped") == :zapped

    assert Trie.lookup_value(trie, "a") == nil
    assert Trie.lookup_value(trie, "ab") == nil
    assert Trie.lookup_value(trie, "foo") == nil
  end

  test "all_values" do
    trie =
      Trie.new()
      |> Trie.insert("a", :a)
      |> Trie.insert("abc", :abc)
      |> Trie.insert("add", :add)
      |> Trie.insert("zapped", :zapped)

    assert [:a, :abc, :add, :zapped] = Trie.all_values(trie)
  end

  test "all_values when a list is one of them" do
    trie =
      Trie.new()
      |> Trie.insert("abc", :abc)
      |> Trie.insert("add", [:a, :dd])
      |> Trie.insert("zapped", :zapped)

    assert [:abc, [:a, :dd], :zapped] = Trie.all_values(trie)
  end

end
