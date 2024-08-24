import 'package:flutter/material.dart';

class EmptyMealsInfo extends StatelessWidget {
  const EmptyMealsInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return SliverToBoxAdapter(
      child: SizedBox(
        height: mediaQuery.size.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Упс...тут ничего нету',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Попробуй выбрать другую категорию',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
