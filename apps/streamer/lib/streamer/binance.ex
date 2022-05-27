defmodule Streamer.Binance do
  use WebSockex

  @stream_endpoint Application.get_env(:streamer, :streamer_endpoint)

  def start_link(symbol) do
    WebSockex.start_link(
      "#{@stream_endpoint}/#{symbol}@trade",
      __MODULE__,
      nil
    )
  end

  def handle_frame({type, msg}, state) do
    IO.puts("Received Message - Type: #{inspect type} -- Message #{inspect msg}")
    {:ok, state}
  end
end
