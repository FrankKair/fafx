## forex-api

Minimalist (no auth) API that uses the [fafx](https://github.com/FrankKair/fafx) gem to retrieve foreign currencies' rates. API mostly used to test new frameworks and languages, such as [Elm](https://github.com/FrankKair/elm-forex).

(Tested with Ruby 2.6.3p62).

### Requirements & running

`make deps` to install the dependencies ([sinatra](http://sinatrarb.com/) web framework and [fafx](https://github.com/FrankKair/fafx)).

`make run` to start the server.

### Endpoints

/currencies
```ruby
=> { "currencies": ["USD", "GBP", "CAD", "SEK", "NOK", ...] }
```

/to (Example call: GET **localhost:USD/to/GBP**)
```ruby
=> { "result": 1.2951645399597045 }
```
