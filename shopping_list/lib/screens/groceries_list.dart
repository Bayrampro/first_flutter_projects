import 'package:flutter/material.dart';
import 'package:shopping_list/screens/new_item.dart';
import '../models/models.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final groceryItem =
        await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (context) => const NewItem(),
    ));

    if (groceryItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(groceryItem);
    });
  }

  void _onDismissed(int index) {
    setState(() {
      _groceryItems.remove(_groceryItems[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Твои продукты'),
            actions: [
              IconButton(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
              )
            ],
          ),
          _groceryItems.isEmpty
              ? SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ничего не найдено',
                        style: theme.textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'попробуй добавить продукт',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )
              : SliverList.builder(
                  itemCount: _groceryItems.length,
                  itemBuilder: (context, index) => Dismissible(
                    key: ValueKey(index),
                    onDismissed: (DismissDirection direction) =>
                        _onDismissed(index),
                    background: Container(
                      color: Colors.red,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
                      leading: Container(
                        width: 30,
                        height: 30,
                        color: _groceryItems[index].category.color,
                      ),
                      title: Text(_groceryItems[index].name),
                      trailing: Text(
                        '${_groceryItems[index].quantity}',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
