import 'package:cryptocoins/data/models/wallet.dart';
import 'package:cryptocoins/data/models/coin.dart';

abstract interface class WalletRepository {
  Wallet getWallet();
  void addCoin(Coin coin);
  void removeCoin(Coin coin);
}

class WalletRepositoryImpl implements WalletRepository {
  final Wallet _wallet = Wallet(coins: []);

  @override
  Wallet getWallet() {
    return _wallet;
  }

  @override
  void addCoin(Coin coin) {
    _wallet.addCoin(coin);
  }

  @override
  void removeCoin(Coin coin) {
    _wallet.removeCoin(coin);
  }

}
