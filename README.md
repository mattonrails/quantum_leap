# QuantumLeap

[![Build Status](https://secure.travis-ci.org/mattonrails/quantum_leap.png?branch=master)](http://travis-ci.org/mattonrails/quantum_leap)

Righting wrongs in your test suite with time travel!

QuantumLeap lets you change the current time in your tests.

I can't promise you'll meet any historical figures, however.

## Installation

Add this line to your application's Gemfile:

    gem 'quantum_leap'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quantum_leap

## Usage

    require 'quantum_leap'

    Quantum.leap(Time.new(1956, 9, 13))
    sam.must_be_kind_of(Pilot)
    sam.must_win_baseball_game
    Quantum.leap_back

Or with a block:

    Quantum.leap(Time.new(1974, 10, 24)) do
      sam.must_be_kind_of(Boxer)
      sam.must_win_the_championship
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
