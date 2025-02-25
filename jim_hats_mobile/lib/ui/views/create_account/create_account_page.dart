import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/routing/app_routes.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/shared/ui/controllers/hide_password_controller.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:jim_hats_mobile/shared/utils/form_sanitizers.dart';
import 'package:jim_hats_mobile/shared/utils/form_validators.dart';
import 'package:jim_hats_mobile/ui/views/create_account/cubit/create_account_page_cubit.dart';

class CreateAccountPage extends StatefulWidget {
  final CreateAccountPageCubit createAccountPageCubit;
  CreateAccountPage({super.key, CreateAccountPageCubit? createAccountPageCubit})
      : createAccountPageCubit =
            createAccountPageCubit ?? locator.get<CreateAccountPageCubit>();

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
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
          bloc: widget.createAccountPageCubit,
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
                  bloc: widget.createAccountPageCubit,
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TakePhotoWidget(
                                  onPhotoChosen: (photo) {
                                    Navigator.of(context).pop();
                                    if (photo != null) {
                                      widget.createAccountPageCubit
                                          .addImage(photo);
                                    }
                                  },
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TakePhotoWidget(
                                  onPhotoChosen: (photo) {
                                    Navigator.of(context).pop();
                                    if (photo != null) {
                                      widget.createAccountPageCubit
                                          .addImage(photo);
                                    }
                                  },
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
                  bloc: widget.createAccountPageCubit,
                  buildWhen: (previous, current) {
                    return previous.image != current.image;
                  },
                  builder: (context, state) {
                    if (state.image != null) {
                      return Align(
                        child: TextButton(
                            onPressed: () {
                              widget.createAccountPageCubit.clearImage();
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
                  initialValue: widget.createAccountPageCubit.state.username,
                  validator: FormValidators.validateUsername,
                  onChanged: (value) {
                    widget.createAccountPageCubit
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
                  initialValue: widget.createAccountPageCubit.state.email,
                  validator: FormValidators.validateEmail,
                  onChanged: (value) {
                    widget.createAccountPageCubit
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
                        initialValue:
                            widget.createAccountPageCubit.state.password,
                        obscureText: hidePasswordController.isHidden,
                        onChanged: (value) {
                          widget.createAccountPageCubit.updatePassword(value);
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
                        initialValue:
                            widget.createAccountPageCubit.state.confirmPassword,
                        validator: FormValidators.validatePassword,
                        onChanged: (value) {
                          widget.createAccountPageCubit
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
                      bloc: widget.createAccountPageCubit,
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
    widget.createAccountPageCubit.submitForm();
  }

  void _toggleHidePassword() {
    hidePasswordController.toggle();
  }
}
