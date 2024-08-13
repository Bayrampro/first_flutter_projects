// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptoCoinAdapter extends TypeAdapter<CryptoCoin> {
  @override
  final int typeId = 2;

  @override
  CryptoCoin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoCoin(
      name: fields[1] as String,
      details: fields[2] as CryptoCoinDetail,
    );
  }

  @override
  void write(BinaryWriter writer, CryptoCoin obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.details);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoCoinAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CryptoCoinDetailAdapter extends TypeAdapter<CryptoCoinDetail> {
  @override
  final int typeId = 1;

  @override
  CryptoCoinDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoCoinDetail(
      imageUrl: fields[1] as String,
      currentPrice: fields[2] as double,
      lowIn24h: fields[3] as double,
      highIn24h: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CryptoCoinDetail obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.currentPrice)
      ..writeByte(3)
      ..write(obj.lowIn24h)
      ..writeByte(4)
      ..write(obj.highIn24h);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoCoinDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetail _$CryptoCoinDetailFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetail(
      imageUrl: json['IMAGEURL'] as String,
      currentPrice: (json['PRICE'] as num).toDouble(),
      lowIn24h: (json['LOW24HOUR'] as num).toDouble(),
      highIn24h: (json['HIGH24HOUR'] as num).toDouble(),
    );

Map<String, dynamic> _$CryptoCoinDetailToJson(CryptoCoinDetail instance) =>
    <String, dynamic>{
      'IMAGEURL': instance.imageUrl,
      'PRICE': instance.currentPrice,
      'LOW24HOUR': instance.lowIn24h,
      'HIGH24HOUR': instance.highIn24h,
    };
