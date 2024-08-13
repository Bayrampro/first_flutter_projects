part of 'coin_screen_bloc.dart';

abstract class CryptoCoinState extends Equatable{}

class CryptoCoinInitial extends CryptoCoinState{
  @override
  List<Object?> get props => [];
}

class LoadCryptoCoinState extends CryptoCoinState{
  @override
  List<Object?> get props => [];
}

class LoadedCryptoCoinState extends CryptoCoinState{
  LoadedCryptoCoinState({required this.coinList});

  final List<CryptoCoin> coinList;

  @override
  List<Object?> get props => [coinList];
}

class LoadingFailureCryptoCoinState extends CryptoCoinState{
  LoadingFailureCryptoCoinState({required this.exeption});

  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}