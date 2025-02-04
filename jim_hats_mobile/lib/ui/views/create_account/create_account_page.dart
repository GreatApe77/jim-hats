import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/shared/ui/controllers/hide_password_controller.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final hidePasswordController = HidePasswordController(
    isHidden: true
  );

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
              'Create account',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 12,
            ),
            Text('An account is required to use the app.',
                style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(
              height: 12,
            ),
            Align(
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                height: 100,
                width: 100,
                child: Material(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  shape: CircleBorder(),
                  child: InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {},
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image,
                            size: 32,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Icon(Icons.edit_outlined),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Name'),
              ),
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
                  if (hidePasswordController.isHidden) {
                    return TextField(
                      obscureText: hidePasswordController.isHidden,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Password'),
                          suffixIcon: IconButton(
                              onPressed: () => _toggleHidePassword(),
                              icon: Icon(Icons.visibility_off))),
                    );
                  }

                  return TextField(
                    obscureText: hidePasswordController.isHidden,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Password'),
                        suffixIcon: IconButton(
                            onPressed: () => _toggleHidePassword(),
                            icon: Icon(Icons.visibility))),
                  );
                }),
            SizedBox(
              height: 16,
            ),
            ListenableBuilder(
                listenable: hidePasswordController,
                builder: (context, child) {
                  if (hidePasswordController.isHidden) {
                    return TextField(
                      obscureText: hidePasswordController.isHidden,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Confirm password'),
                          suffixIcon: IconButton(
                              onPressed: () => _toggleHidePassword(),
                              icon: Icon(Icons.visibility_off))),
                    );
                  }

                  return TextField(
                    obscureText: hidePasswordController.isHidden,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Confirm password'),
                        suffixIcon: IconButton(
                            onPressed: () => _toggleHidePassword(),
                            icon: Icon(Icons.visibility))),
                  );
                }),
            SizedBox(
              height: 16,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(onPressed: () {}, child: Text('Create account'))
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'By siging up, you are agreeing to the Terms of Service and Privacy Policy',
              textAlign: TextAlign.center,
            )
          ],
        ),
      )),
    );
  }

  void _toggleHidePassword() {
    hidePasswordController.toggle();
  }
}
