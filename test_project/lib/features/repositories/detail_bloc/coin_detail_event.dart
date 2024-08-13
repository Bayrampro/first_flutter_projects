import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class CryptoCoinDetailEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadCryptoCoinDetailEvent extends CryptoCoinDetailEvent{

  LoadCryptoCoinDetailEvent({required this.currency, this.completer,});

  final String? currency;
  final Completer? completer;

  @override
  List<Object?> get props => [currency];
}