import 'package:cryptocoins/data/repositories/coin_repository.dart';
import 'package:cryptocoins/data/models/coin_catalog.dart';
import 'package:cryptocoins/data/models/coin.dart';

abstract interface class CoinCatalogRepository {
  Future<List<Coin>> fetchInitialCoins();
  Future<List<Coin>> fetchMoreCoins();
  Coin getById(String id);
  Coin getByPosition(int position);
  bool hasMoreCoins();
}

class CoinCatalogRepositoryImpl implements CoinCatalogRepository {
  final CoinRepository _coinRepository;
  final CoinCatalog _catalog = CoinCatalog();
  final int _perPage;
  final String _currency;

  CoinCatalogRepositoryImpl({
    required CoinRepository coinRepository,
    int perPage = 20,
    String currency = 'usd',
  })  : _coinRepository = coinRepository,
        _perPage = perPage,
        _currency = currency;

  @override
  Future<List<Coin>> fetchInitialCoins() async {
    try {
      List<Coin> coins = await _coinRepository.fetchCoins(
        page: 1,
        perPage: _perPage,
        currency: _currency,
      );
      _catalog.results = coins;
      _catalog.next = '2';
      _catalog.count = coins.length;
      return coins;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Coin>> fetchMoreCoins() async {
    try {
      if (_catalog.next == null) {
        return [];
      }

      List<Coin> coins = await _coinRepository.fetchCoins(
        page: int.parse(_catalog.next!),
        perPage: _perPage,
        currency: _currency,
      );
      _catalog.results!.addAll(coins);
      _catalog.next = (int.parse(_catalog.next!) + 1).toString();
      _catalog.count = _catalog.results!.length;
      return coins;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Coin getById(String id) {
    return _catalog.results!.firstWhere((element) => element.id == id);
  }

  @override
  Coin getByPosition(int position) {
    return _catalog.results![position];
  }

  @override
  bool hasMoreCoins() {
    return _catalog.next != null;
  }
}