import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_project/features/repositories/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CoinScreenRepository{

  CoinScreenRepository({
    required this.dio,
    required this.cryptoCoinsBox,
  });

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  Future<List<CryptoCoin>> getCoinList() async{
    var cryptoCoinsList = <CryptoCoin>[];
    Future<List<CryptoCoin>> _fetchCryptoCoinsFromApi() async {
      final response = await dio.get("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,BNB,ETH,SOL,CAG,AID,DOV&tsyms=USD");
      final data = response.data as Map<String, dynamic>;
      final dataRaw = data["RAW"] as Map<String, dynamic>;
      final dataList = dataRaw.entries.map((e) {
        final dataUsd = (e.value as Map<String, dynamic>)["USD"] as Map<String, dynamic>;
        final details = CryptoCoinDetail.fromJson(dataUsd);
        return CryptoCoin(
          name: e.key,
          details: details,
        );
      }).toList();

      return dataList;
    }
    cryptoCoinsList = await _fetchCryptoCoinsFromApi();
    // print('first box ${cryptoCoinsBox.values}');
    // try{
    //   cryptoCoinsList = await _fetchCryptoCoinsFromApi();
    //   final dataMap = {
    //     for (var e in cryptoCoinsList)
    //       e.name: e
    //   };
    //   await cryptoCoinsBox.putAll(dataMap);
    //   print("cryptoCoinBox ${cryptoCoinsBox.values}");
    // }
    // catch(e, st){
    //   print("cryptoCoinBox ${cryptoCoinsBox.values}");
    //   GetIt.I<Talker>().handle(e, st);
    //   cryptoCoinsList = cryptoCoinsBox.values.toList();
    // }

    cryptoCoinsList.sort((a, b) => b.details.currentPrice.compareTo(a.details.currentPrice));
    return cryptoCoinsList;
  }

  Future<CryptoCoin> getCoinDetailList(currency) async{
    Future<CryptoCoin> _fetchCryptoCoinDetailsFromApi(currency) async {
      final response = await dio.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currency&tsyms=USD');
      final data = response.data as Map<String, dynamic>;
      final dataRaw = data['RAW'] as Map<String, dynamic>;
      final dataDetail = dataRaw[currency] as Map<String, dynamic>;
      final dataDetailUSD = dataDetail['USD'] as Map<String, dynamic>;
      final details = CryptoCoinDetail.fromJson(dataDetailUSD);

      return CryptoCoin(
        name: currency,
        details: details,
      );
    }
    final coin = await _fetchCryptoCoinDetailsFromApi(currency);
    return coin;
    // try{
    //   final coin = await _fetchCryptoCoinDetailsFromApi(currency);
    //   cryptoCoinsBox.put(currency, coin);
    //   return coin;
    // }
    // catch(e, st) {
    //   GetIt.I<Talker>().handle(e, st);
    //   return cryptoCoinsBox.get(currency)!;
    // }
  }
}