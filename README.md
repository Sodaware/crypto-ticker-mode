# crypto-ticker-mode

## Description

**crypto-ticker-mode** is an Emacs minor mode for displaying crypto currency
exchange rates in the mode line.

![crypto-ticker-mode](/crypto-ticker-mode.png)


## Configuration

By default, **crypto-ticker-mode** is configured to fetch the latest
Dogecoin/USD exchange rate from the [Cryptsy](http://cryptsy.com/) public API.

### Configuring the Display

To change the displayed currency symbols, modify the following variable:

* `crypto-ticker-mode-currency-from-symbol` - This is the starting currency,
  such as BTC or DOGE.
* `crypto-ticker-mode-currency-to-symbol` - The currency being converted to,
  such as $ or £.

**NOTE** - Changing the symbols does not change the actual rate calculation.


### Other Configuration Options

**crypto-ticker-mode** also provides the following configuration options:

* `crypto-ticker-mode-api-poll-interval` - The number of seconds the ticker will
  wait between rate checks. By default this is 10 minutes.

* `crypto-ticker-mode-symbol-increased` - The symbol that displays in the
  modeline when the exchange rate has increased. This is an up-arrow by default.

* `crypto-ticker-mode-symbol-decreased` - The symbol displayed in the modeline
  when the exchange rate has decreased. This is a down-arrow by default.

* `crypto-ticker-mode-symbol-same` - Displayed when the price hasn't
  changed. This is a dash by default.


### Configuring the Cryptsy Driver

To change the displayed exchange rate, the following variable should be
modified:

* `crypto-ticker-mode-driver-cryptsy-market-id` - This is the Cryptsy market ID
  to fetch data for. A full list of markets can be found on the Cryptsy
  homepage.


### Changing Drivers

To change the driver, set the `crypto-ticker-mode-driver` variable to be a valid
function that returns the current exchange rate. 


### Configuration Example

The following configuration would display the current Bitcoin/USD exchange rate:

```el
(setq crypto-ticker-mode-from-symbol "BTC")
(setq crypto-ticker-mode-to-symbol "$")
(setq crypto-ticker-mode-driver-cryptsy-market-id 2)
```


## Licence

Copyright (C) 2014 Phil Newton

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
Street, Fifth Floor, Boston, MA 02110-1301, USA.
