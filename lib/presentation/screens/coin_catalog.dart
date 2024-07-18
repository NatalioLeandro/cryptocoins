import 'package:cryptocoins/data/repositories/coin_repository.dart';
import 'package:cryptocoins/presentation/widgets/button.dart';
import 'package:cryptocoins/presentation/widgets/card.dart';
import 'package:cryptocoins/core/constants/constants.dart';
import 'package:cryptocoins/config/routes.dart' as routes;
import 'package:cryptocoins/data/models/coin.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CoinCatalogPage extends StatefulWidget {
  const CoinCatalogPage({super.key});

  @override
  State<CoinCatalogPage> createState() => _CoinCatalogPageState();
}

class _CoinCatalogPageState extends State<CoinCatalogPage> {
  int _currentPage = 1;
  late Future<List<Coin>> _coins;
  String _selectedCurrency = 'brl';

  @override
  void initState() {
    super.initState();
    _coins = _fetchCoins();
  }

  Future<List<Coin>> _fetchCoins() {
    return Provider.of<CoinRepositoryImpl>(context, listen: false).fetchCoins(
      page: _currentPage,
      currency: _selectedCurrency,
    );
  }

  void _loadNextPage() {
    setState(() {
      _currentPage++;
      _coins = _fetchCoins();
    });
  }

  void _loadPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
        _coins = _fetchCoins();
      });
    }
  }

  void _onCurrencyChanged(String? newCurrency) {
    if (newCurrency != null) {
      setState(() {
        _selectedCurrency = newCurrency;
        _coins = _fetchCoins();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cryptocoins'),
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                routes.walletRoute,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              menuMaxHeight: 200,
              itemHeight: 48,
              value: _selectedCurrency,
              onChanged: _onCurrencyChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).primaryColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              dropdownColor: Theme.of(context).primaryColor,
              style: const TextStyle(color: Colors.white),
              iconEnabledColor: Colors.white,
              items: Constants.currencies
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase(),
                      style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              selectedItemBuilder: (BuildContext context) {
                return Constants.currencies.map<Widget>((String value) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      value.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList();
              },
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return FutureBuilder<List<Coin>>(
                        future: _coins,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Erro ao carregar moedas'),
                            );
                          }

                          final coins = snapshot.data!;

                          return Column(
                            children:
                                coins.map((coin) => CoinCard(coin)).toList(),
                          );
                        },
                      );
                    },
                    childCount: 1,
                  ),
                ),
                SliverToBoxAdapter(
                  child: FutureBuilder<List<Coin>>(
                    future: _coins,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Button(
                                onPressed: _loadPreviousPage,
                                child: const Text('Anterior'),
                              ),
                              Button(
                                onPressed: _loadNextPage,
                                child: const Text('Próxima'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
