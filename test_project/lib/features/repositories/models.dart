import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@HiveType(typeId: 2)
class CryptoCoin extends Equatable {

  CryptoCoin({required this.name, required this.details});

  @HiveField(1)
  final String name;
  @HiveField(2)
  final CryptoCoinDetail details;

  @override
  List<Object?> get props => [name];

}

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail extends Equatable{

  CryptoCoinDetail({
    required this.imageUrl,
    required this.currentPrice,
    required this.lowIn24h,
    required this.highIn24h
  });

  @HiveField(1)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  @HiveField(2)
  @JsonKey(name: 'PRICE')
  final double currentPrice;

  @HiveField(3)
  @JsonKey(name: 'LOW24HOUR')
  final double lowIn24h;

  @HiveField(4)
  @JsonKey(name: 'HIGH24HOUR')
  final double highIn24h;

  String get fullImageUrl => 'https://www.cryptocompare.com/$imageUrl';

  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) => _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  @override
  List<Object?> get props => [imageUrl, currentPrice, lowIn24h, highIn24h];

}