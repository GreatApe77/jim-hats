import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/routing/app_routes.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/shared/ui/controllers/hide_password_controller.dart';
import 'package:jim_hats_mobile/shared/ui/cubits/auth/auth_cubit.dart';
import 'package:jim_hats_mobile/shared/utils/form_sanitizers.dart';
import 'package:jim_hats_mobile/shared/utils/form_validators.dart';
import 'package:jim_hats_mobile/ui/views/sign_in/bloc/sign_in_page_bloc.dart';

class SignInPage extends StatefulWidget {
  final SignInPageBloc signInPageBloc;
  const SignInPage({super.key, required this.signInPageBloc});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  final hidePasswordController = HidePasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: BlocListener<SignInPageBloc, SignInPageState>(
        bloc: locator.get<SignInPageBloc>(),
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case SignInPageStatus.success:
              locator.get<AuthCubit>().checkAuthStatus();
              //Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              break;
            case SignInPageStatus.failure:
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                    SnackBar(content: Text('Error while logging in')));
              break;
            default:
          }
        },
        child: Form(
          key: formKey,
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
                  TextFormField(
                    validator: FormValidators.validateUsername,
                    onChanged: (value) {
                      widget.signInPageBloc.add(SignInUsernameChanged(
                          username: FormSanitizers.sanitizeUsername(value)));
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Username'),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ListenableBuilder(
                      listenable: hidePasswordController,
                      builder: (context, child) {
                        return TextFormField(
                          validator: FormValidators.validatePassword,
                          onChanged: (value) {
                            widget.signInPageBloc
                                .add(SignInPasswordChanged(password: value));
                          },
                          obscureText: hidePasswordController.isHidden,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Password'),
                              suffixIcon: IconButton(
                                  onPressed: () => _toggleHidePassword(),
                                  icon: Icon(hidePasswordController.isHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                        );
                      }),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<SignInPageBloc, SignInPageState>(
                    bloc: widget.signInPageBloc,
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return FilledButton(
                          onPressed: state.status == SignInPageStatus.loading
                              ? null
                              : () => _submitSignIn(),
                          child: Text('Sign in'));
                    },
                  ),
                  FilledButton.tonal(
                      onPressed: () {}, child: Text('Reset password')),
                  Row(
                    children: [
                      Text('Trouble signing in? '),
                      GestureDetector(
                        child: Text(
                          'Contact support.',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      )),
    );
  }

  void _submitSignIn() {
    if (!formKey.currentState!.validate()) return;
    widget.signInPageBloc.add(SignInFormSubmitted());
  }

  void _toggleHidePassword() {
    hidePasswordController.toggle();
  }
}
