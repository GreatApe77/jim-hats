import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/core/utils/form_validators.dart';
import 'package:jim_hats_mobile/presentation/cubits/join_group_page/join_group_page_cubit.dart';

class JoinGroupPage extends StatefulWidget {
  const JoinGroupPage({super.key, required this.joinGroupPageCubit});
  final JoinGroupPageCubit joinGroupPageCubit;
  @override
  State<JoinGroupPage> createState() => _JoinGroupPageState();
}

class _JoinGroupPageState extends State<JoinGroupPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacings.horizontalPadding.toDouble()),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      'Join Group',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Enter a group code to join',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      initialValue: widget.joinGroupPageCubit.state.groupCode,
                      validator: (value) =>
                          FormValidators.validateGroupCode(value),
                      onChanged: (value) {
                        widget.joinGroupPageCubit.updateGroupCode(value);
                      },
                      decoration: InputDecoration(
                          label: Text('Group code'),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Looks like',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '• afb78e50-e830-46f9-b20b-5aeb0c0040ad',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocConsumer<JoinGroupPageCubit, JoinGroupPageState>(
                          bloc: widget.joinGroupPageCubit,
                          listener: (context, state) {
                            if (state.status == JoinGroupPageStatus.error) {
                              ScaffoldMessenger.of(context)
                                ..clearSnackBars()
                                ..showSnackBar(SnackBar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                    content: Text(state.errorMessage)));
                            }
                            if (state.status == JoinGroupPageStatus.success) {
                              Navigator.of(context).pop();
                            }
                          },
                          listenWhen: (previous, current) =>
                              previous.status != current.status,
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return FilledButton(
                                onPressed:
                                    state.status == JoinGroupPageStatus.loading
                                        ? null
                                        : _submitForm,
                                child: Text(
                                  state.status==JoinGroupPageStatus.loading?
                                    'Joining...'
                                  :
                                    'Join challenge'
                                ));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    widget.joinGroupPageCubit.submitForm();
  }
}
