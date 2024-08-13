part of 'coin_screen_bloc.dart';

abstract class CryptoCoinEvent extends Equatable{}

class LoadCryptoCoinEvent extends CryptoCoinEvent{
    LoadCryptoCoinEvent({this.completer});
    final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
