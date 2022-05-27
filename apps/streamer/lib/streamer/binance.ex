defmodule Streamer.Binance do
  @moduledoc """
  Streamer.Binance contains the logic to comunicate
  with the binance websocket
  """

  use WebSockex

  require Logger

  alias Streamer.Binance.TradeEvent

  @stream_endpoint Application.compile_env(:streamer, :streamer_endpoint)

  def start_link(symbol) do
    WebSockex.start_link(
      "#{@stream_endpoint}/#{symbol}@trade",
      __MODULE__,
      nil
    )
  end

  def handle_frame({type, msg}, state) do
    case Jason.decode(msg) do
      {:ok, event} -> process_event(event)
      {:error, _} -> Logger.error("unable to parse msg: #{msg}")
    end

    {:ok, state}
  end

  defp process_event(%{"e" => "trade"} = msg) do
    trade_event = TradeEvent.build(msg)
    Logger.debug("Trade event received #{trade_event.symbol}@#{trade_event.price}")
  end
end
