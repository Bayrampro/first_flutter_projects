
import 'package:go_router/go_router.dart';
import '../../generated/l10n.dart';
import '../coin_detail/coin_detail.dart';
import '../coins_screen/coin_screen_list.dart';
import 'package:flutter/material.dart';

GoRouter createRouter(Function(Locale) onLocaleChange) {
  final routes = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) =>
              MyHomePage(
                title: S
                  .of(context)
                  .cryptoCoinsList,
                onLocaleChange: onLocaleChange,
              ),
        ),
        GoRoute(
          path: '/coins_details/:coin',
          builder: (context, state) {
            final coin = state.pathParameters['coin']!;
            return CoinsDetail(coinName: coin, onLocaleChange: onLocaleChange);
          },
        ),
      ]
  );
  return routes;
}