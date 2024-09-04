import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/data.dart';
import 'package:shopping_list/screens/new_item.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = false;
  bool _error = false;

  void _loadItems() async {
    try {
      final url = Uri.https(
        'fir-backend-d1814-default-rtdb.firebaseio.com',
        'shopping-list.json',
      );
      final response = await http.get(url);
      if (response.body == 'null') {
        return;
      }
      _isLoading = true;
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<GroceryItem> loadedItems = [];
      for (final item in responseBody.entries) {
        final category = categories.entries
            .firstWhere(
                (element) => element.value.name == item.value['category'])
            .value;
        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }
      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
      log(response.statusCode.toString());
    } catch (e) {
      log('Ошибка $e');
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _addItem() async {
    await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (context) => const NewItem(),
    ));

    _loadItems();
  }

  void _onDismissed(GroceryItem groceryItem) async {
    final index = _groceryItems.indexOf(groceryItem);
    setState(() {
      _groceryItems.remove(groceryItem);
    });
    final url = Uri.https(
      'fir-backend-d1814-default-rtdb.firebaseio.com',
      'shopping-list/${groceryItem.id}.json',
    );
    final response = await http.delete(url);
    if (response.statusCode <= 400) {
      _groceryItems.insert(index, groceryItem);
    }
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
          if (_isLoading)
            const SliverFillRemaining(
                child: Center(
              child: CircularProgressIndicator(),
            ))
          else if (_error)
            SliverFillRemaining(
                child: Center(
              child: Text(
                textAlign: TextAlign.center,
                'Упс что то пошло не так попробуй позже',
                style: theme.textTheme.headlineLarge,
              ),
            ))
          else if (_groceryItems.isEmpty)
            SliverFillRemaining(
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
          else
            SliverList.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (context, index) => Dismissible(
                key: ValueKey(index),
                onDismissed: (DismissDirection direction) =>
                    _onDismissed(_groceryItems[index]),
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
                  contentPadding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0),
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
