import 'package:equatable/equatable.dart';
import 'package:test_project/features/repositories/models.dart';

abstract class CryptoCoinDetailState extends Equatable{
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailInitial extends CryptoCoinDetailState{
  @override
  List<Object?> get props => [];
}

class LoadCryptoCoinDetailState extends CryptoCoinDetailState{
  @override
  List<Object?> get props => [];
}

class LoadedCryptoCoinDetailState extends CryptoCoinDetailState{
  LoadedCryptoCoinDetailState({required this.coinDetailList});

  final CryptoCoin coinDetailList;

  @override
  List<Object?> get props => [coinDetailList];
}

class LoadingFailureCryptoCoinDetailState extends CryptoCoinDetailState{
  LoadingFailureCryptoCoinDetailState({required this.exeption});

  final Object? exeption;

  @override
  List<Object?> get props => [exeption];
}