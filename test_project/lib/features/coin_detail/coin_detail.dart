import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/features/repositories/detail_bloc/coin_detail_state.dart';

import '../../lang_switcher/lang_switcher.dart';
import '../repositories/coin_screen/coin_screen_repository.dart';
import '../repositories/detail_bloc/coin_detail_bloc.dart';
import '../repositories/detail_bloc/coin_detail_event.dart';
import 'package:test_project/generated/l10n.dart';

class CoinsDetail extends StatefulWidget {
  const CoinsDetail({Key? key, required this.coinName, required this.onLocaleChange}) : super(key: key);

  final String coinName;
  final Function(Locale) onLocaleChange;

  @override
  State<CoinsDetail> createState() => _CoinsDetailState();
}

class _CoinsDetailState extends State<CoinsDetail> {

  final _cryptoCoinDetail = CryptoCoinDetailBloc(coinScreenRep: GetIt.I<CoinScreenRepository>());

  @override
  void initState() {
    _cryptoCoinDetail.add(LoadCryptoCoinDetailEvent(currency: widget.coinName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left_outlined),
          onPressed: (){
            context.go('/');
          },
        ),
        actions: [
          LanguageSwitcher(onLocaleChange: widget.onLocaleChange),
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(widget.coinName, style: Theme.of(context).appBarTheme.titleTextStyle,),
        centerTitle: true,
      ),
      body: BlocBuilder<CryptoCoinDetailBloc, CryptoCoinDetailState>(
            bloc: _cryptoCoinDetail,
            builder: (context, state) {
              if(state is LoadedCryptoCoinDetailState){
                return Container(
                  child: Column(
                    children: [
                      Image.network(state.coinDetailList.details.fullImageUrl),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        padding: EdgeInsets.fromLTRB(100, 13, 100, 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black54,
                        ),
                        child: Text(
                          '${double.parse(state.coinDetailList.details.currentPrice.toStringAsFixed(5))}\$',
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black54,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                      S.of(context).lowPriceIn24Hours,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    '${double.parse(state.coinDetailList.details.lowIn24h.toStringAsFixed(5))}\$',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    S.of(context).highPriceIn24Hours,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    '${double.parse(state.coinDetailList.details.highIn24h.toStringAsFixed(5))}\$',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              else if (state is LoadingFailureCryptoCoinDetailState){
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
                        onPressed: (){_cryptoCoinDetail.add(LoadCryptoCoinDetailEvent(currency: widget.coinName));},
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
              else{
                return Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        tooltip: 'Refresh',
        onPressed: () async{
          final completer = Completer();
          _cryptoCoinDetail.add(LoadCryptoCoinDetailEvent(currency: widget.coinName, completer: completer));
          completer.future;
        },
        child: Icon(Icons.refresh, color: Colors.white,),
      ),
    );
  }
}