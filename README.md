# FAFX

[![CI](https://github.com/FrankKair/fafx/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/FrankKair/fafx/actions/workflows/ci.yml)

FAFX fetches data from the 90 day European Central Bank (ECB) feed and offers a simple CLI to interect with.

## Installation

    $ gem install fafx

## CLI

    $ fafx

```
Usage: fafx [options]
        --recent      Lists most recent rates
        --currencies  Lists available currencies
        --dates       Lists available dates
        --update      Fetches new data from the web
```

## Example of client usage

```ruby
require 'fafx'

# Gets the most recent rates
Fafx::ExchangeRate.get('GBP', 'USD')
# => 1.2951645399597045

Fafx::ExchangeRate.at(Date.today, 'GBP', 'USD')
# => 1.2951645399597045

Fafx::ExchangeRate.currencies_available
# => ["EUR", "USD", "JPY", "BGN", "CZK", ...]

Fafx::ExchangeRate.dates_available
# => ["2018-09-10", "2018-09-07", "2018-09-06", "2018-09-05", ...]

Fafx::ExchangeRate.most_recent
# => {"USD"=>1.1571, "JPY"=>128.54, "BGN"=>1.9558, "CZK"=>25.648, ...}
```

The `at` function may raise a `DateError` or `CurrencyError` exception, should the date or currency be unavailable. Passing an object other than `Date` to `at` raises `DateError` as well.

Exchange rates are loaded once per process and cached in memory. Calling `update_data` refreshes the on-disk cache and clears the in-memory cache so subsequent lookups use the latest data.

## Updating the exchange rates data

You can update the exchange rates values either via the **CLI**, **Rake task** or **programmatically**:

    $ fafx --update

    $ rake update_data

```ruby
require 'fafx'

Fafx::ExchangeRate.update_data
```
