import numpy as np

import requests

DOMAIN = 'https://alphavantage.co'
TOKEN = 'YMB67WYG870H5FZ0'

function = 'OVERVIEW'

cached = {}

symbols = [
  'META',
  'AMZN',
  'MSFT',
  'AAPL',
  'GOOG',
];

def print_pretty(symbol, cap):
    if cap is not None:
        # cap = int(cap/1e6)

        cached[symbol] = cap

        if cap > 1000:
            cap /= 1000
            if cap > 1000:
                cap /= 1000
                print (f'{symbol}:\t{cap} T $')
            else:
                print (f'{symbol}:\t{cap} B $')
        else:
            print(f'{symbol}:\t{cap} m $')
    else:
        print(f'{symbol}:\t??')

def fetch_sym(symbol):
    if symbol not in cached:
        fullurl = DOMAIN + f'/query?function={function}&symbol={symbol}&apikey={TOKEN}'

        resp = requests.get(fullurl)

        data = resp.json()
        print(resp.text)
        if 'MarketCapitalization' in data:
            cap = data['MarketCapitalization']
            if cap is not None and cap:
                cap = int(cap)
                cached[symbol] = cap

                print_pretty(symbol, cap)
                print(cap)
                return cap
    return None

def fetch():
    HEADERS = {}

    for symbol in symbols:
        fetch_sym(symbol)

def get_cap(symbol):
    if symbol in cached:
        return cached[symbol]
    else:
        return fetch_sym(symbol)

def get_all_caps():
    fetch()
    return cached


if __name__ == '__main__':
    print (get_all_caps())
