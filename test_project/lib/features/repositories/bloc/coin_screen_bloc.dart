import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_project/features/repositories/coin_screen/coin_screen_repository.dart';

import '../models.dart';

part 'coin_screen_event.dart';
part 'coin_screen_state.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  CryptoCoinBloc({required this.coinScreenRep}) : super(CryptoCoinInitial()){

    on<LoadCryptoCoinEvent>((event, emit) async{
      try{
        if (state is! LoadedCryptoCoinState){
          emit(LoadCryptoCoinState());
        }
        final coinList = await coinScreenRep.getCoinList();
        emit(LoadedCryptoCoinState(coinList: coinList));
      }
      catch (e, st){
        emit(LoadingFailureCryptoCoinState(exeption: e));
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
    //Yokarky handle etmedik zatlary handle etyar
    GetIt.I<Talker>().handle(error, stackTrace);
    super.onError(error, stackTrace);
  }
}