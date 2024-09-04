import 'package:favorite_places/features/place_detail_screen/place_detail.dart';
import 'package:favorite_places/models/models.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/widgets.dart';

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});

  @override
  ConsumerState<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends ConsumerState<PlacesListScreen> {
  void _addItem(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => const PlaceAddingForm(),
    );
  }

  void _goToDetail(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaceDetailScreen(place: place),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ref.read(placesProvider.notifier).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final List<Place> placesList = ref.watch(placesProvider);
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Любимые места'),
            actions: [
              IconButton(
                onPressed: () => _addItem(context),
                icon: const Icon(Icons.add),
              )
            ],
          ),
          placesList.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Ничего еще не добавлено',
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  sliver: SliverList.builder(
                    itemCount: placesList.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () => _goToDetail(context, placesList[index]),
                      leading: CircleAvatar(
                        radius: 26,
                        backgroundImage: FileImage(placesList[index].image),
                      ),
                      title: Text(
                        placesList[index].title,
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      subtitle: Text(
                        placesList[index].placeLocation.adress,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onPrimaryContainer
                              .withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
