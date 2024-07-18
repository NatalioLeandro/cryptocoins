import 'package:cryptocoins/providers/wallet_provider.dart';
import 'package:cryptocoins/data/models/coin.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final Coin coin;

  const FavoriteButton(
    this.coin, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var isInWallet = context.select<WalletProvider, bool>(
      (wallet) => wallet.wallet.coins.contains(coin),
    );

    return IconButton(
      icon: Icon(
        isInWallet ? Icons.favorite : Icons.favorite_border,
        color: isInWallet ? Colors.red : Colors.grey,
      ),
      onPressed: isInWallet
          ? () {
              var wallet = context.read<WalletProvider>();
              wallet.removeCoin(coin);
            }
          : () {
              var wallet = context.read<WalletProvider>();
              wallet.addCoin(coin);
            },
    );
  }
}
