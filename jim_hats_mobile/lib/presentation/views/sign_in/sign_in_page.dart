import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/core/utils/validators/password_validator.dart';
import 'package:jim_hats_mobile/core/utils/validators/username_validator.dart';
import 'package:jim_hats_mobile/core/utils/validators/validatable.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/presentation/controllers/hide_password_controller.dart';
import 'package:jim_hats_mobile/core/utils/form_sanitizers.dart';
import 'package:jim_hats_mobile/presentation/blocs/sign_in_page/sign_in_page_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInPageBloc>(
      create: (context) => locator.get<SignInPageBloc>(),
      child: SignInView(),
    );
  }
}

class SignInView extends StatelessWidget {
  SignInView({
    super.key,
  });

  final formKey = GlobalKey<FormState>();

  final hidePasswordController = HidePasswordController();
  final Validatable<String> _usernameValidator = UsernameValidator();
  final Validatable<String> _passwordValidator = PasswordValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: BlocListener<SignInPageBloc, SignInPageState>(
        bloc: context.read<SignInPageBloc>(),
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case SignInPageStatus.success:
              //locator.get<AuthCubit>().checkAuthStatus();
              Navigator.of(context).pushReplacementNamed(AppRoutes.splash);
              break;
            case SignInPageStatus.failure:
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(SnackBar(content: Text(state.message)));
              break;
            default:
          }
        },
        child: Form(
          key: formKey,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacings.horizontalPadding),
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
                    key: Key('SignInView.username_field'),
                    validator: _usernameValidator.validate,
                    onChanged: (value) {
                      context.read<SignInPageBloc>().add(SignInUsernameChanged(
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
                          key: Key('SignInView.password_field'),
                          validator: _passwordValidator.validate,
                          onChanged: (value) {
                            context
                                .read<SignInPageBloc>()
                                .add(SignInPasswordChanged(password: value));
                          },
                          obscureText: hidePasswordController.isHidden,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Password'),
                              suffixIcon: IconButton(
                                key: Key('SignInView.toggle_password_btn'),
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
                    bloc: context.read<SignInPageBloc>(),
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return FilledButton(
                        key: Key('SignInView.sign_in_button'),
                          onPressed: state.status == SignInPageStatus.loading
                              ? null
                              : () => _submitSignIn(context),
                          child: Text(state.status == SignInPageStatus.loading
                              ? 'Signing in...'
                              : 'Sign in'));
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

  void _submitSignIn(BuildContext context) {
    if (!formKey.currentState!.validate()) return;
    context.read<SignInPageBloc>().add(SignInFormSubmitted());
  }

  void _toggleHidePassword() {
    hidePasswordController.toggle();
  }
}
