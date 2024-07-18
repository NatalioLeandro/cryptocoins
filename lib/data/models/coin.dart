import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double? currentPrice;
  final int marketCap;
  final int marketCapRank;
  final double? high24H;
  final double? low24H;
  final double? priceChange24H;
  final double? priceChangePercentage24H;

  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    this.currentPrice = 0.0,
    required this.marketCap,
    required this.marketCapRank,
    this.high24H = 0.0,
    this.low24H = 0.0,
    this.priceChange24H = 0.0,
    this.priceChangePercentage24H = 0.0,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price'] != null ? double.tryParse(json['current_price'].toString()) ?? 0.0 : 0.0,
      marketCap: json['market_cap'],
      marketCapRank: json['market_cap_rank'],
      high24H: json['high_24h'] != null ? double.tryParse(json['high_24h'].toString()) ?? 0.0 : 0.0,
      low24H: json['low_24h'] != null ? double.tryParse(json['low_24h'].toString()) ?? 0.0 : 0.0,
      priceChange24H: json['price_change_24h'] != null ? double.tryParse(json['price_change_24h'].toString()) ?? 0.0 : 0.0,
      priceChangePercentage24H: json['price_change_percentage_24h'] != null ? double.tryParse(json['price_change_percentage_24h'].toString()) ?? 0.0 : 0.0,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      'high_24h': high24H,
      'low_24h': low24H,
      'price_change_24h': priceChange24H,
      'price_change_percentage_24h': priceChangePercentage24H,
    };
  }

  Coin copyWith({
    String? id,
    String? symbol,
    String? name,
    String? image,
    double? currentPrice,
    int? marketCap,
    int? marketCapRank,
    double? high24H,
    double? low24H,
    double? priceChange24H,
    double? priceChangePercentage24H,
  }) {
    return Coin(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCap: marketCap ?? this.marketCap,
      marketCapRank: marketCapRank ?? this.marketCapRank,
      high24H: high24H ?? this.high24H,
      low24H: low24H ?? this.low24H,
      priceChange24H: priceChange24H ?? this.priceChange24H,
      priceChangePercentage24H:
          priceChangePercentage24H ?? this.priceChangePercentage24H,
    );
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        image,
        currentPrice,
        marketCap,
        marketCapRank,
        high24H,
        low24H,
        priceChange24H,
        priceChangePercentage24H,
      ];
}
