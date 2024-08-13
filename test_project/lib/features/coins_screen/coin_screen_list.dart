import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_project/features/coins_screen/widgets/CoinsListTile.dart';

import '../../lang_switcher/lang_switcher.dart';
import '../repositories/bloc/coin_screen_bloc.dart';
import '../repositories/coin_screen/coin_screen_repository.dart';
import 'package:test_project/generated/l10n.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.onLocaleChange});


  final String title;
  final Function(Locale) onLocaleChange;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _cryptoCoin = CryptoCoinBloc(coinScreenRep: GetIt.I<CoinScreenRepository>());

  @override
  void initState() {
    _cryptoCoin.add(LoadCryptoCoinEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: LanguageSwitcher(onLocaleChange: widget.onLocaleChange),
          backgroundColor: Theme
              .of(context)
              .appBarTheme
              .backgroundColor,
          title: Text(widget.title, style: Theme
              .of(context)
              .appBarTheme
              .titleTextStyle),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TalkerScreen(talker: GetIt.I<Talker>())));
                },
                icon: Icon(Icons.document_scanner_outlined)
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async{
            final completer = Completer();
            _cryptoCoin.add(LoadCryptoCoinEvent(completer: completer));
            completer.future;
          },
          child: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
              bloc: _cryptoCoin,
              builder: (context, state) {
                if (state is LoadedCryptoCoinState) {
                  return ListView.separated(
                      separatorBuilder: (context, i) => Divider(),
                      itemCount: state.coinList.length,
                      itemBuilder: (context, i) {
                        final coin = state.coinList[i];
                        return CoinsListTile(coin: coin,);
                      }
                  );
                }
                else if (state is LoadingFailureCryptoCoinState){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            S.of(context).somethingWentWrong,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.0,
                              fontSize: 20,
                            ),
                        ),
                        Text(
                          S.of(context).pleaseTryAgain,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextButton(
                          onPressed: (){_cryptoCoin.add(LoadCryptoCoinEvent());},
                          child: Text(S.of(context).tryAgain),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Colors.yellow),
                            padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                            ),
                            overlayColor: MaterialStateProperty.all(Colors.yellow.withOpacity(0.2)),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                else {
                  return Center(child: CircularProgressIndicator(),);
                }
              }
          ),
        )
    );
  }
}