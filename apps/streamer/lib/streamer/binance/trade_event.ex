defmodule Streamer.Binance.TradeEvent do
  @moduledoc """
  This module represents a trading event that occurs on Binance
  """

  defstruct [
    :event_type,
    :event_time,
    :symbol,
    :trade_id,
    :price,
    :quantity,
    :buyer_order_id,
    :seller_order_id,
    :trade_time,
    :buyer_market_maker
  ]

  def build(msg) do
    %__MODULE__{
      event_type: msg["e"],
      event_time: msg["E"],
      symbol: msg["s"],
      trade_id: msg["t"],
      price: msg["p"],
      quantity: msg["q"],
      buyer_order_id: msg["b"],
      seller_order_id: msg["a"],
      trade_time: msg["T"],
      buyer_market_maker: msg["m"]
    }
  end
end
