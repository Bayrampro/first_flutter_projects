import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';
import 'widgets.dart';

class PlaceAddingForm extends ConsumerStatefulWidget {
  const PlaceAddingForm({
    super.key,
  });

  @override
  ConsumerState<PlaceAddingForm> createState() => _PlaceAddingFormState();
}

class _PlaceAddingFormState extends ConsumerState<PlaceAddingForm> {
  final _fromKey = GlobalKey<FormState>();
  String title = '';
  File? _selectedImage;
  PlaceLocation? _placeLocation;
  bool _isGettingLocation = false;

  String? _titleValidator(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length <= 1 ||
        value.trim().length >= 50) {
      return 'Имя должно быть больше 1 и меньше 50';
    }
    return null;
  }

  void _titleOnSaved(newValue) {
    title = newValue;
  }

  void _onSubmit() async {
    if (_fromKey.currentState!.validate() &&
        _selectedImage != null &&
        _placeLocation != null) {
      _fromKey.currentState!.save();
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(_selectedImage!.path);
      final copiedImage =
          await _selectedImage!.copy('${appDir.path}/$fileName');
      ref.read(placesProvider.notifier).addPlace(
            Place(
              title: title,
              image: copiedImage,
              placeLocation: _placeLocation!,
            ),
          );
      Navigator.of(context).pop();
    }
  }

  void _chooseCamera() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      _selectedImage = File(image.path);
      Navigator.of(context).pop();
    });
  }

  void _chooseGallery() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      _selectedImage = File(image.path);
      Navigator.of(context).pop();
    });
  }

  void _chooseVariant() {
    final theme = Theme.of(context);
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: theme.scaffoldBackgroundColor,
          title: Text(
            'Выбери вариант',
            style:
                theme.textTheme.titleLarge!.copyWith(color: theme.canvasColor),
          ),
          content: DialogContent(
            chooseCamera: _chooseCamera,
            chooseGallery: _chooseGallery,
          ),
        ),
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            'Выбери вариант',
            style:
                theme.textTheme.titleLarge!.copyWith(color: theme.canvasColor),
          ),
          content: DialogContent(
            chooseCamera: _chooseCamera,
            chooseGallery: _chooseGallery,
          ),
        ),
      );
    }
  }

  void _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    // const double lt = 38.8951;
    // const double ln = -77.0364;
    final double? lt = locationData.latitude;
    final double? ln = locationData.longitude;

    if (lt == null || ln == null) {
      return;
    }

    setState(() {
      _isGettingLocation = true;
    });

    final url = Uri.parse(
        'https://geocode.maps.co/reverse?lat=$lt&lon=$ln&api_key=66d1d7af175f0260565461lev8dfafe');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final adress = resData['display_name'];
    setState(() {
      _isGettingLocation = false;
      _placeLocation = PlaceLocation(
        ln: ln,
        lt: lt,
        adress: adress,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardSpace = mediaQuery.viewInsets.bottom;
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: theme.scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, keyboardSpace + 12.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: mediaQuery.size.height * 0.85,
            child: Form(
              key: _fromKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(
                      color: theme.canvasColor,
                    ),
                    decoration: const InputDecoration(
                      label: Text('Имя'),
                    ),
                    validator: _titleValidator,
                    maxLength: 50,
                    onSaved: _titleOnSaved,
                  ),
                  const SizedBox(height: 10),
                  ImageInput(
                    chooseVariant: _chooseVariant,
                    selectedImage: _selectedImage,
                  ),
                  const SizedBox(height: 10),
                  LocationInput(
                    onPressed: _getLocation,
                    placeLocation: _placeLocation,
                    isGettingLocation: _isGettingLocation,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _onSubmit,
                    icon: const Icon(Icons.add),
                    label: const Text('Добавить место'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
