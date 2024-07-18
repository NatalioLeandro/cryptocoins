import 'package:cryptocoins/core/secrets/secrets.dart';
import 'package:cryptocoins/data/models/coin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract interface class CoinRepository {
  Future<List<Coin>> fetchCoins({
    int? page,
    int? perPage,
    String? order,
    String? currency,
  });
}

class CoinRepositoryImpl implements CoinRepository {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';
  static const String _coinsUrl = '$_baseUrl/coins/markets';

  @override
  Future<List<Coin>> fetchCoins({
    int? page,
    int? perPage,
    String? order,
    String? currency,
  }) async {
    try {
    final response = await http.get(
      Uri.parse(
          '$_coinsUrl?vs_currency=$currency&page=$page&per_page=$perPage&order=$order'),
      headers: {
        'accept': 'application/json',
        "x-cg-demo-api-key": Secrets.apiKey,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Coin> coins =
          body.map((dynamic item) => Coin.fromJson(item)).toList();
      return coins;
    } else {
      throw Exception('Erro ao carregar moedas');
    }
    } catch (e) {
      rethrow;
    }
  }
}