import 'package:cryptocoins/data/models/coin.dart';

class CoinCatalog {
  int? count;
  String? next;
  String? previous;
  List<Coin>? results;

  CoinCatalog({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory CoinCatalog.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Coin> results = list.map((i) {
      return Coin.fromJson(i);
    }).toList();

    return CoinCatalog(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: results,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results?.map((e) => e.toJson()).toList(),
    };
  }

  CoinCatalog copyWith({
    int? count,
    String? next,
    String? previous,
    List<Coin>? results,
  }) {
    return CoinCatalog(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}