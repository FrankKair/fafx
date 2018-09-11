# FAFX

[![Build Status](https://travis-ci.org/FrankKair/fafx.svg?branch=master)](https://travis-ci.org/FrankKair/fafx)

### Installation

`$ gem install fafx`

### CLI

`$ fafx`

```
Usage: fafx [options]
        --recent      Lists most recent rates
        --currencies  Lists available currencies
        --dates       Lists available dates
        --update      Fetches new data from the web
```

### Example of client usage

```ruby
require 'Date'
require 'fafx'

puts Fafx::ExchangeRate.at(Date.today, 'GBP', 'USD')
puts Fafx::ExchangeRate.currencies_available
puts Fafx::ExchangeRate.dates_available
puts Fafx::ExchangeRate.most_recent
```

This code outputs:

```
1.2951995012468827

USD
JPY
BGN
CZK
...

2018-09-07
2018-09-06
2018-09-05
2018-09-04
...

{"USD"=>1.1615, "JPY"=>128.74, "BGN"=>1.9558, "CZK"=>25.697 ... }
```

### Updating the exchange rates data

You can update the exchange rates values via the CLI using:

`$ fafx --update`

One can also use the `$ rake update_data` task as well.