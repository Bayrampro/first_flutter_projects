import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_project/features/repositories/coin_screen/coin_screen_repository.dart';
import 'package:test_project/features/repositories/detail_bloc/coin_detail_event.dart';
import 'package:test_project/features/repositories/detail_bloc/coin_detail_state.dart';

class CryptoCoinDetailBloc
    extends Bloc<CryptoCoinDetailEvent, CryptoCoinDetailState> {
  CryptoCoinDetailBloc({required this.coinScreenRep})
      : super(CryptoCoinDetailInitial()){

    on<LoadCryptoCoinDetailEvent>((event, emit) async{

      try{
        if (state is! LoadedCryptoCoinDetailState){
          emit(LoadCryptoCoinDetailState());
        }
        final coinDetailList = await coinScreenRep.getCoinDetailList(event.currency);
        emit(LoadedCryptoCoinDetailState(coinDetailList: coinDetailList));
      }
      catch (e, st){
        emit(LoadingFailureCryptoCoinDetailState(exeption: e));
        //blocdaky yalnyshlyklar ucin handle
        GetIt.I<Talker>().handle(e, st);
      }
      finally{
        event.completer?.complete();
      }
    });
  }
  final CoinScreenRepository coinScreenRep;

  @override
  void onError(Object error, StackTrace stackTrace) {
    GetIt.I<Talker>().handle(error, stackTrace);
    //Yokarky handle etmedik zatlary handle etyar
    super.onError(error, stackTrace);
  }
}