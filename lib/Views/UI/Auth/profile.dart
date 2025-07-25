import 'package:anti_inflammatory_app/Utils/colors.dart';
import 'package:anti_inflammatory_app/Utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controllers/authVm.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _referrelController = TextEditingController();
  final _levelController = TextEditingController();
  bool _private = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthVm>().user;
    _nameController.text = user?.name ?? '';
    _emailController.text = user?.email ?? '';
    _referrelController.text = user?.referral ?? '';
    _levelController.text = user?.level.toString() ?? '';
    _private = user?.isPrivate ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVm>(builder: (context, p, c) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(14),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: p.isLoading
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.42),
                      child: const CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                          backgroundColor: AppColors.primaryColor))
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_nameController.text.isEmpty ||
                              _emailController.text.isEmpty) {
                            snackBarColorF(
                                'Please enter your name and email', context);
                          } else {
                            p.updateProfile(context,
                                name: _nameController.text,
                                email: _emailController.text);
                          }
                        }
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      )),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: _referrelController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Referrel',
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your referrel';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // TextFormField(
                    //   controller: _levelController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Level',
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your level';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // CheckboxListTile(
                    //   title: const Text('Private'),
                    //   value: _private,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _private = value ?? false;
                    //     });
                    //   },
                    // ),
                    const SizedBox(height: 20),
                  ]))));
    });
  }
}
