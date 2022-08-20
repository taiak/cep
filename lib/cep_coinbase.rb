# get, parse and show exchanges from coinbase.com
# CoinExchangeParser
class CEP_COINBASE
  require 'json'
  require 'ostruct'
  require 'net/http'

  attr_reader :exchanges, :currency_type

  BASE_LINK     = 'https://api.coinbase.com/v2/exchange-rates?currency=#CURRENCY#'.freeze

  # XXX: this part can be added to the manual. But not now :)
  # default value hash.
  # TRY will be change to lira
  VAR_NAMES     = { 'TRY' => 'lira'}.freeze

  # default coin currency type
  CURRENCY_TYPE = 'ETH'.freeze
  # default coinbase.com result json hierarchy
  Hierarcy      = ['data', 'rates'].freeze
  # default cache folder
  CacheFolder   = 'logs/'.freeze

  def initialize(
          base_link:     BASE_LINK,
          vars:          VAR_NAMES,
          currency_type: CURRENCY_TYPE,
          write_cache:   true,
          hierarcy:      Hierarcy,
          cache_file:    nil,
          cache_folder:  CacheFolder
  )
    @currency_type= currency_type
    @base_link    = base_link

    make_new_link

    @var_names    = vars
    @write_status = write_cache
    @hierarcy     = hierarcy
    @cache_file   = cache_file
    @cache_folder = cache_folder
    @exchanges    = {}
  end

  # get exchanges or read the cache file
  def fetch
    set_cache_file
    body
  end

  # TODO: Write function more manageable
  # parse data to object
  def process
    data = parse_exchanges
    data = get_pure_data data

    # make hash for currency array
    data.each do |n, v|
      v_f = v.to_f
      @exchanges[n] = v_f if set_ins(n, v_f)
    end
  rescue
    throw 'Initialization problem!'
  end

  # rename objects
  # this function overwrite default exchange values
  # with
  def rename_param
    @var_names.each do |old, new| 
      @body.gsub!(old, new) 
    end
  end

  # write @body to cache file
  def cache
    # if must write to cache
    return false unless @write_status || @body

    # if cache file exists ignore caching
    return true if File.exists? @cache_file

    File.open(@cache_folder + @cache_file, 'w') do |cache|
      cache.write @body
    end
  rescue
    throw 'caching problem(s) occurs!'
  end

  private

  def make_new_link
    @link = @base_link.gsub('#CURRENCY#',
                            @currency_type)
  end

  # name like 'name' and value is an object
  # set attr_reader for name
  # and add obj to variable
  def set_ins(name, obj)
    name = name.dup.downcase
    self.class.__send__(:attr_reader, name)
    instance_variable_set('@' + name, obj)
  rescue
    return false
  end

  def get_pure_data(data)
    # go into hash
    @hierarcy.each { |str| data = data[str] }
    return data
  rescue
    throw 'unknowing exchange type'
  end

  # convert @body to hash
  def parse_exchanges
    @data_content = JSON.parse(@body)
  rescue
    throw 'JSON parse error!'
  end

  # get @body from url link
  def link
    Net::HTTP.get(URI.parse(@link))
  end

  # get @body from file
  def file
    File.read @cache_file
  end

  # if cache_file name not exits
  # remake name
  def set_cache_file
    return @cache_file if @cache_file

    # TODO: make cache file format changable
    time = Time.new.strftime '%y.%m.%d_%H'
    @cache_file = "#{@currency_type}_#{time}.data"
  end

  # select body source and get
  def body
    @body = File.exist?(@cache_file) ? file : link
  end
end
