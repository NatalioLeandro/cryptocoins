import 'package:cryptocoins/presentation/screens/coin_catalog.dart';
import 'package:cryptocoins/presentation/screens/wallet.dart';
import 'package:cryptocoins/presentation/screens/splash.dart';
import 'package:flutter/material.dart';

const String walletRoute = '/wallet';
const String coinCatalogRoute = '/';
const String splashRoute = '/splash';

Route controller(RouteSettings settings) {
  switch (settings.name) {
    case walletRoute:
      return MaterialPageRoute(
        builder: (context) => const WalletPage(),
      );
    case splashRoute:
      return MaterialPageRoute(
        builder: (context) => const SplashPage(),
      );
    case coinCatalogRoute:
    default:
      return MaterialPageRoute(
        builder: (context) => const CoinCatalogPage(),
      );
  }
}
