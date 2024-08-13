import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/features/repositories/models.dart';

class CoinsListTile extends StatelessWidget {

  const CoinsListTile({Key? key, required this.coin}) : super(key: key);

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final coinName = coin.name;
    final coinDetails = coin.details;
    return ListTile(
      leading: Image.network(coinDetails.fullImageUrl),
      title: Text(
        coin.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        "${coinDetails.currentPrice} \$",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: (){
        // Navigator.of(context).pushNamed(
        //   '/coins_details',
        //   arguments: coinName,
        // );
        context.go('/coins_details/${coinName}'); // Using go_router to navigate
      },
    );
  }
}