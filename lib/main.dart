import 'package:cryptocoins/data/repositories/coin_catalog_repository.dart';
import 'package:cryptocoins/data/repositories/coin_repository.dart';
import 'package:cryptocoins/providers/wallet_provider.dart';
import 'package:cryptocoins/data/models/coin_catalog.dart';
import 'package:cryptocoins/config/routes.dart' as routes;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => CoinCatalog()),
        Provider(create: (_) => CoinRepositoryImpl()),
        Provider(
          create: (_) => CoinCatalogRepositoryImpl(
            coinRepository: context.read<CoinRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => WalletProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'CryptoCoins',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: routes.controller,
        initialRoute: routes.splashRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
