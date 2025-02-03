import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/shared/ui/controllers/hide_password_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final hidePasswordController = HidePasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacings.horizontalPadding.toDouble()),
              child: ListView(
                children: [
                  Text(
                    'Sign in',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Welcome back.',
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Email'),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ListenableBuilder(
                      listenable: hidePasswordController,
                      builder: (context, child) {
                        if (hidePasswordController.hideBalance) {
                          return TextField(
                            obscureText: hidePasswordController.hideBalance,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Password'),
                                suffixIcon: IconButton(
                                    onPressed: () => _toggleHidePassword(),
                                    icon: Icon(Icons.visibility_off))),
                          );
                        }

                        return TextField(
                          obscureText: hidePasswordController.hideBalance,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Password'),
                              suffixIcon: IconButton(
                                  onPressed: () => _toggleHidePassword(),
                                  icon: Icon(Icons.visibility))),
                        );
                      }),
                ],
              ))),
    );
  }

  void _toggleHidePassword() {
    hidePasswordController.toggle();
  }
}
