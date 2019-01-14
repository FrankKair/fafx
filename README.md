# FAFX

[![Build Status](https://travis-ci.org/FrankKair/fafx.svg?branch=master)](https://travis-ci.org/FrankKair/fafx)

FAFX fetches data from the 90 day European Central Bank (ECB) feed and offers a simple CLI and API to interect with.

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
require 'Date'
require 'fafx'

Fafx::ExchangeRate.at(Date.today, 'GBP', 'USD')
# => 1.2951645399597045

Fafx::ExchangeRate.currencies_available
# => ["USD", "JPY", "BGN", "CZK", ...]

Fafx::ExchangeRate.dates_available
# => ["2018-09-10", "2018-09-07", "2018-09-06", "2018-09-05", ...]

Fafx::ExchangeRate.most_recent
# => {"USD"=>1.1571, "JPY"=>128.54, "BGN"=>1.9558, "CZK"=>25.648, ...}
```

The `at` function may raise a `DateError` or `CurrencyError` exception, should the date or currency be unavailable.

## Updating the exchange rates data

You can update the exchange rates values either via the **CLI**, **Rake task** or **programmatically**:

    $ fafx --update

    $ rake update_data

```ruby
require 'fafx'

Fafx::ExchangeRate.fetch_data_and_save_to_disk
```

---

One can also schedule a **cron job** (the following example fetches the data every minute):

```
* * * * * . ~/.zshrc; fafx -u
```

Note: `. ~/.zshrc` is used to load the environment with the Ruby gems path, because cron uses `PATH=/usr/bin:/usr/sbin` and `SHELL=/usr/bin/sh` by default. Fonts: [here](http://man7.org/linux/man-pages/man5/crontab.5.html) and [here](http://www.adminschoice.com/crontab-quick-reference)
