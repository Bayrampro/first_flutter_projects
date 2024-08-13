import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_project/features/repositories/coin_screen/coin_screen_repository.dart';
import 'package:test_project/features/repositories/models.dart';
import 'package:test_project/features/theme/theme.dart';
import 'package:test_project/generated/l10n.dart';
import 'features/routes/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

    WidgetsFlutterBinding.ensureInitialized();
    final talker = TalkerFlutter.init();
    GetIt.I.registerSingleton(talker);
    GetIt.I<Talker>().debug('Talker started...');

    await Hive.initFlutter();

    Hive.registerAdapter(CryptoCoinAdapter());
    Hive.registerAdapter(CryptoCoinDetailAdapter());

    var cryptoCoinsBox = await Hive.openBox<CryptoCoin>('crypto_coins_box');

    final dio = Dio();
    // Adding TalkerDioLogger to Dio interceptors
    dio.interceptors.add(
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          printResponseData: false,
        ),
      ),
    );
    // Setting up Bloc observer with Talker
    Bloc.observer = TalkerBlocObserver(
      talker: talker,
    );

    GetIt.I.registerLazySingleton(() => CoinScreenRepository(dio: dio, cryptoCoinsBox: cryptoCoinsBox));

    // Uncomment if Firebase is needed
    // final app = await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // talker.info(app.options.projectId);

    // Handling Flutter UI errors
    FlutterError.onError = (details) => GetIt.I<Talker>().handle(details.exception, details.stack);
    runApp(const CryptoCoinsList());
}

class CryptoCoinsList extends StatefulWidget {
  const CryptoCoinsList({super.key});

  @override
  State<CryptoCoinsList> createState() => _CryptoCoinsListState();
}

class _CryptoCoinsListState extends State<CryptoCoinsList> {
    Locale _locale = Locale('en');

    void _setLocale(Locale locale) {
      setState(() {
        _locale = locale;
      });
    }

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = createRouter(_setLocale);

    return MaterialApp.router(
      locale: _locale,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Crypto Coins List',
      theme: theme,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      // navigatorObservers: [
      //   TalkerRouteObserver(GetIt.I<Talker>()),
      // ],
    );
  }
}


