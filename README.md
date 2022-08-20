# CEP COINBASE
Coin Exchange Parser(CEP) is a functional exchange calculation class which converts json data received from coinbase.com and uses it as a class method.

~~~ruby
require 'cep_coinbase'
c = CEP_COINBASE.new(currency_type: 'ETH')
c.fetch   # fetch values from server
c.process # process fetched json values
c.usd     # ETH-USD value
c.try     # ETH-TRY value
c.btc     # ETH-BTC value
c.exchanges # show all available exchange values with currency values
c.exchanges.keys # all available exchange pairs for currency
~~~
