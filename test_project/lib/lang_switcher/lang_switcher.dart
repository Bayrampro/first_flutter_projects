import 'package:flutter/material.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({Key? key, required this.onLocaleChange}) : super(key: key);
  final Function(Locale) onLocaleChange;

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {

  void _changeLanguage(String languageCode) {
    setState(() {});
    widget.onLocaleChange(Locale(languageCode));
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('English'),
                onTap: () {
                  _changeLanguage('en');
                  Navigator.of(context).pop(); // Закрываем диалоговое окно
                },
              ),
              ListTile(
                title: Text('Русский'),
                onTap: () {
                  _changeLanguage('ru');
                  Navigator.of(context).pop(); // Закрываем диалоговое окно
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 7),
        IconButton(
          onPressed: _showLanguageDialog,
          icon: Icon(Icons.public, color: Colors.white,),
        ),
      ],
    );
  }
}