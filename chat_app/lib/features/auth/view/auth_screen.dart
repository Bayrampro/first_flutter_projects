import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _firebaseAuth = GetIt.I.get<FirebaseAuth>();
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _isLoading = false;
  String _enteredUsername = '';
  String _enteredEmail = '';
  String _enteredPassword = '';
  File? _uploadingImage;

  String? _usernameValidator(String? value) {
    if (value == null || value.isEmpty || value.trim().length < 4) {
      return 'Пожалуйста введите правильно';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty || !value.trim().contains('@')) {
      return 'Пожалуйста введите правильный mail';
    }
    return null;
  }

  String? _passwordValidator(value) {
    if (value == null || value.trim().length < 6) {
      return 'Символы должны быть больше чем 6';
    }
    return null;
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate() ||
        !_isLogin && _uploadingImage == null) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_isLogin) {
        final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        log(userCredential.toString());
      } else {
        final userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredential.user!.uid}.jpg');
        await storageRef.putFile(_uploadingImage!);
        final imageUrl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'imageUrl': imageUrl,
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Auth Failed'),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 300,
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/img/chat.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    SwitchBar(
                      onPressed: () => setState(() => _isLogin = !_isLogin),
                      isLogin: _isLogin,
                    ),
                    if (!_isLogin)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: UserImagePicker(
                          onPickImage: (pickedImage) =>
                              _uploadingImage = pickedImage,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (!_isLogin)
                              TextFormField(
                                style: TextStyle(
                                  color: theme.primaryColor,
                                ),
                                decoration: const InputDecoration(
                                  label: Text('Имя'),
                                ),
                                autocorrect: true,
                                enableSuggestions: true,
                                validator: _usernameValidator,
                                onSaved: (newValue) =>
                                    _enteredUsername = newValue!,
                              ),
                            TextFormField(
                              style: TextStyle(
                                color: theme.primaryColor,
                              ),
                              decoration: const InputDecoration(
                                label: Text('Почта'),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: _emailValidator,
                              onSaved: (newValue) => _enteredEmail = newValue!,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              style: TextStyle(
                                color: theme.primaryColor,
                              ),
                              decoration: const InputDecoration(
                                label: Text('Пароль'),
                              ),
                              obscureText: true,
                              validator: _passwordValidator,
                              onSaved: (newValue) =>
                                  _enteredPassword = newValue!,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              onPressed: _onSubmit,
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text('Отправить'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
