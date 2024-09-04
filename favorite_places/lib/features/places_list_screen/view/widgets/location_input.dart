import 'package:flutter/material.dart';

import '../../../../models/models.dart';

class LocationInput extends StatelessWidget {
  const LocationInput({
    super.key,
    required this.onPressed,
    this.placeLocation,
    required this.isGettingLocation,
  });

  final VoidCallback onPressed;
  final PlaceLocation? placeLocation;
  final bool isGettingLocation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget content = Text(
      'Локация еще не выбрана',
      style: TextStyle(color: theme.canvasColor),
    );
    if (isGettingLocation) {
      content = const CircularProgressIndicator();
    }
    if (placeLocation != null) {
      content = Image.network(
        'https://maps.geoapify.com/v1/staticmap?style=osm-bright&width=600&height=400&center=lonlat:${placeLocation!.ln},${placeLocation!.lt}&zoom=14&apiKey=4e1b45f7999c441c953dbbb257666ab9',
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: theme.colorScheme.secondaryContainer,
            ),
          ),
          child: content,
        ),
        Positioned(
          bottom: 5,
          left: 5,
          right: 5,
          child: IconButton(
            style: IconButton.styleFrom(
                backgroundColor:
                    theme.colorScheme.primaryContainer.withOpacity(0.7),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 20)),
            onPressed: onPressed,
            icon: const Icon(
              Icons.location_on,
            ),
          ),
        )
      ],
    );
  }
}
