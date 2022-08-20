# CEP COINBASE
Coin Exchange Parser(CEP) is a functional exchange calculation class which converts json data received from coinbase.com and uses it as a class method.

# Installation

~~~ruby
gem install cepc_coinbase
~~~

# Usage Example

~~~ruby
require 'cep_coinbase'
c = CEP_COINBASE.new(currency_type: 'ETH')
c.fetch   # fetch values from coinbase.com
c.process # process fetched json values

c.usd     # ETH-USD value
c.try     # ETH-TRY value
c.btc     # ETH-BTC value
c.nocoin  # If nocoin not exists in exchange list this line will throw error

c.exchanges # show all available exchange values with currency values
c.exchanges.keys # all available exchange pairs for currency

c.exchanges['USD'] # ETH-USD value
c.exchanges['TRY'] # ETH-TRY value
c.exchanges['BTC'] # ETH-BTC value
c.exchanges['NOCOIN']  # If NOCOIN not exists in exchange list this line will return nil value

~~~
