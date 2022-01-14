import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'E9CE6B53-63A5-4F13-871C-E58872F718F6';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      var requestUrl =
          Uri.parse('$coinApiUrl/$crypto/$selectedCurrency?apikey=$apiKey');
      http.Response response = await http.get(requestUrl);

      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        var lastPrice = decodeData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
