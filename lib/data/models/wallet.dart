import 'package:cryptocoins/data/models/coin.dart';

class Wallet {
  List<Coin> coins;

  Wallet({
    required this.coins,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    var list = json['coins'] as List;
    List<Coin> coins = list.map((i) {
      return Coin.fromJson(i);
    }).toList();

    return Wallet(
      coins: coins,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coins': coins.map((e) => e.toJson()).toList(),
    };
  }

  Wallet copyWith({
    List<Coin>? coins,
  }) {
    return Wallet(
      coins: coins ?? this.coins,
    );
  }

  void addCoin(Coin coin) {
    coins.add(coin);
  }

  void removeCoin(Coin coin) {
    coins.removeWhere((item) => item.id == coin.id);
  }

}
