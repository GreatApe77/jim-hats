import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/presentation/controllers/hide_password_controller.dart';
import 'package:jim_hats_mobile/presentation/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:jim_hats_mobile/core/utils/form_sanitizers.dart';
import 'package:jim_hats_mobile/core/utils/form_validators.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_account_page/create_account_page_cubit.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateAccountPageCubit>(
      //create: (context) => locator.get<CreateAccountPageCubit>(),
      create: (context) => locator.get<CreateAccountPageCubit>(),
      child: CreateAccountView(),
    );
  }
}

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  late final HidePasswordController hidePasswordController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    hidePasswordController = HidePasswordController(isHidden: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSpacings.horizontalPadding.toDouble()),
        child: BlocListener<CreateAccountPageCubit, CreateAccountPageState>(
          bloc: context.read<CreateAccountPageCubit>(),
          listener: (context, state) {
            switch (state.status) {
              case Status.error:
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      content: Text(state.errorMessage)));
                break;
              case Status.success:
                Navigator.of(context).pushNamed(AppRoutes.signin);
                break;
              default:
                return;
            }
          },
          listenWhen: (previous, current) {
            return previous.status != current.status;
          },
          child: Form(
            key: formKey,
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
                // BlocBuilder<CreateAccountPageCubit, CreateAccountPageState>(
                //   bloc: widget.createAccountPageCubit,
                //   builder: (context, state) {
                //     if (state.image != null) {
                //       return Text('TEM IMAGEM');
                //     }
                //     return SizedBox.shrink();
                //   },
                // ),
                BlocBuilder<CreateAccountPageCubit, CreateAccountPageState>(
                  bloc: context.read<CreateAccountPageCubit>(),
                  buildWhen: (previous, current) {
                    return previous.image != current.image;
                  },
                  builder: (context, state) {
                    if (state.image != null) {
                      // return Align(
                      //   alignment: Alignment.center,
                      //   child: Container(
                      //     height: 100,
                      //     width: 100,
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         image: DecorationImage(
                      //           fit: BoxFit.cover,
                      //             image: FileImage(File(state.image!.path)))),
                      //   ),
                      // );
                      return Align(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          height: 100,
                          width: 100,
                          child: InkWell(
                            customBorder: CircleBorder(),
                            onTap: () {
                              final bloc =
                                  context.read<CreateAccountPageCubit>();
                              Navigator.of(context).push(MaterialPageRoute(
                                settings: ModalRoute.of(context)?.settings,
                                builder: (context) => BlocProvider.value(
                                  value: bloc,
                                  child: TakePhotoWidget(
                                    onPhotoChosen: (photo) {
                                      Navigator.of(context).pop();
                                      if (photo != null) {
                                        bloc.addImage(photo);
                                      }
                                    },
                                  ),
                                ),
                              ));
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          FileImage(File(state.image!.path)))),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
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
                      );
                    }

                    return Align(
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        height: 100,
                        width: 100,
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          shape: CircleBorder(),
                          child: InkWell(
                            customBorder: CircleBorder(),
                            onTap: () {
                              final bloc =
                                  context.read<CreateAccountPageCubit>();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: bloc,
                                  child: TakePhotoWidget(
                                    onPhotoChosen: (photo) {
                                      Navigator.of(context).pop();
                                      if (photo != null) {
                                        bloc.addImage(photo);
                                      }
                                    },
                                  ),
                                ),
                              ));
                            },
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
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                BlocBuilder<CreateAccountPageCubit, CreateAccountPageState>(
                  bloc: context.read<CreateAccountPageCubit>(),
                  buildWhen: (previous, current) {
                    return previous.image != current.image;
                  },
                  builder: (context, state) {
                    if (state.image != null) {
                      return Align(
                        child: TextButton(
                            onPressed: () {
                              context
                                  .read<CreateAccountPageCubit>()
                                  .clearImage();
                            },
                            child: Text('Clear profile picture')),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  initialValue:
                      context.read<CreateAccountPageCubit>().state.username,
                  validator: FormValidators.validateUsername,
                  onChanged: (value) {
                    context
                        .read<CreateAccountPageCubit>()
                        .updateUsername(FormSanitizers.sanitizeUsername(value));
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Username'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  initialValue:
                      context.read<CreateAccountPageCubit>().state.email,
                  validator: FormValidators.validateEmail,
                  onChanged: (value) {
                    context
                        .read<CreateAccountPageCubit>()
                        .updateEmail(FormSanitizers.sanitizeEmail(value));
                  },
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
                      return TextFormField(
                        initialValue: context
                            .read<CreateAccountPageCubit>()
                            .state
                            .password,
                        obscureText: hidePasswordController.isHidden,
                        onChanged: (value) {
                          context
                              .read<CreateAccountPageCubit>()
                              .updatePassword(value);
                        },
                        validator: FormValidators.validatePassword,
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
                ListenableBuilder(
                    listenable: hidePasswordController,
                    builder: (context, child) {
                      return TextFormField(
                        obscureText: hidePasswordController.isHidden,
                        initialValue: context
                            .read<CreateAccountPageCubit>()
                            .state
                            .confirmPassword,
                        validator: FormValidators.validatePassword,
                        onChanged: (value) {
                          context
                              .read<CreateAccountPageCubit>()
                              .updateConfirmPassword(value);
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Confirm password'),
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<CreateAccountPageCubit, CreateAccountPageState>(
                      bloc: context.read<CreateAccountPageCubit>(),
                      buildWhen: (previous, current) =>
                          current.status != previous.status,
                      builder: (context, state) {
                        return FilledButton(
                          onPressed: state.status == Status.loading
                              ? null
                              : () => _submitForm(context),
                          child: Text(state.status == Status.loading
                              ? 'Creating...'
                              : 'Create account'),
                        );
                      },
                    )
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
          ),
        ),
      )),
    );
  }

  void _submitForm(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    context.read<CreateAccountPageCubit>().submitForm();
  }

  void _toggleHidePassword() {
    hidePasswordController.toggle();
  }
}
