import 'package:cryptocoins/data/repositories/wallet_repository.dart';
import 'package:cryptocoins/data/models/wallet.dart';
import 'package:cryptocoins/data/models/coin.dart';
import 'package:flutter/material.dart';

class WalletProvider with ChangeNotifier {
  final WalletRepository _walletRepository = WalletRepositoryImpl();

  Wallet get wallet => _walletRepository.getWallet();

  void addCoin(Coin coin) {
    _walletRepository.addCoin(coin);
    notifyListeners();
  }

  void removeCoin(Coin coin) {
    _walletRepository.removeCoin(coin);
    notifyListeners();
  }
}
