import 'package:favorite_places/models/models.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(place.title),
          ),
          SliverFillRemaining(
            child: Stack(
              children: [
                Image.file(
                  place.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 85,
                        backgroundImage: NetworkImage(
                            'https://maps.geoapify.com/v1/staticmap?style=osm-bright&width=600&height=400&center=lonlat:${place.placeLocation.ln},${place.placeLocation.lt}&zoom=14&apiKey=4e1b45f7999c441c953dbbb257666ab9'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: mediaQuery.size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              Colors.black54,
                            ],
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          place.placeLocation.adress,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
