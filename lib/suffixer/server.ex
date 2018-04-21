defmodule Suffixer.Server do
  use GenServer
  require Logger

  defstruct [:trie]

  # ==========================================================================
  # API
  # ==========================================================================

  def get_words_for_suffix(suffix, server \\ __MODULE__) do
    GenServer.call(server, {:get_words, suffix})
  end


  def start_link(opts) do
    GenServer.start_link(__MODULE__, :whatever, opts)
  end

  # ==========================================================================
  # Callbacks
  # ==========================================================================

  @impl true
  def init(_) do
    GenServer.cast(self(), :populate)
    {:ok, %__MODULE__{trie: nil}}
  end

  @impl true
  def handle_cast(:populate, _state) do
    Logger.info("reading wordlist...")

    # this relative path hack works for me locally and should work on Heroku
    words_path = "./assets/corncob_lowercase_modified.txt"
    words_string = File.read!(words_path)

    Logger.info("splitting wordlist...")
    words = String.split(words_string, ~r/\R/, trim: true)

    Logger.info("populating words trie...")
    trie = Enum.reduce(words, Trie.new(), fn
      word, trie -> Trie.insert(trie, String.reverse(word), word)
    end)

    Logger.info("trie constructed!")
    {:noreply, %__MODULE__{trie: trie}}
  end

  @impl true
  def handle_call({:get_words, suffix}, _, state = %__MODULE__{trie: trie}) do
    subtrie = Trie.lookup(trie, String.reverse(suffix))
    result = Trie.all_values(subtrie)
    {:reply, result, state}
  end

end
