import 'package:cryptocoins/presentation/widgets/button.dart';
import 'package:cryptocoins/presentation/widgets/card.dart';
import 'package:cryptocoins/providers/wallet_provider.dart';
import 'package:cryptocoins/config/routes.dart' as routes;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    final walletProvider = context.watch<WalletProvider>();
    final coins = walletProvider.wallet.coins;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
        ),
        title: const Text('Favoritos'),
      ),
      body: coins.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Você ainda não possui moedas favoritadas.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Button(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  routes.coinCatalogRoute,
                      (route) => false,
                );
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      )
          : Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: coins.length,
                itemBuilder: (context, index) {
                  final coin = coins[index];
                  return CoinCard(coin);
                },
              ),
            ),
            Button(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  routes.coinCatalogRoute,
                      (route) => false,
                );
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
