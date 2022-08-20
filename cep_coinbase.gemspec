Gem::Specification.new do |s|
  s.name        = "cep_coinbase"
  s.version     = "0.1.1"
  s.summary     = "Coin Exchange Parser which use coinbase.com values"
  s.description = "Coin Exchange Parser(CEP) is a functional exchange calculation class which converts received json data from coinbase.com and uses it as a class method."
  s.authors     = ["tayak"]
  s.email       = "yasir.kiroglu@gmail.com"
  s.files       = ["lib/cep_coinbase.rb"]
  s.homepage    = "https://github.com/taiak/cep"
  s.license     = "Apache-2.0"
  s.add_runtime_dependency 'net-http', '~> 0.1.1'
  s.add_runtime_dependency 'ostruct',  '~> 0.3.1'
  s.add_runtime_dependency 'json',     '~> 2.5.1'
end