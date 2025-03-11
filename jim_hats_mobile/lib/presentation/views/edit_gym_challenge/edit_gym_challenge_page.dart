import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/core/utils/date_helper.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/edit_gym_challenge_page/edit_gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/image_banner_form/image_banner_form.dart';

class EditGymChallengePage extends StatelessWidget {
  final EditGymChallengePageArguments editGymChallengePageArguments;
  const EditGymChallengePage({
    super.key,
    required this.editGymChallengePageArguments,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditGymChallengePageCubit>(
      create: (context) => locator.get<EditGymChallengePageCubit>()
      ..updateName(editGymChallengePageArguments.gymChallenge.name)
      ..updateDescription(editGymChallengePageArguments.gymChallenge.description)
      ..updateStartAt(editGymChallengePageArguments.gymChallenge.startAt)
      ..updateEndAt(editGymChallengePageArguments.gymChallenge.endAt)
      ,

      
      child: EditGymChallengeView(
        editGymChallengePageArguments: editGymChallengePageArguments,
      ),
    );
  }
}

class EditGymChallengeView extends StatefulWidget {
  final EditGymChallengePageArguments editGymChallengePageArguments;

  const EditGymChallengeView({
    super.key,
    required this.editGymChallengePageArguments,
  });

  @override
  State<EditGymChallengeView> createState() => _EditGymChallengeViewState();
}

class _EditGymChallengeViewState extends State<EditGymChallengeView> {
  late final TextEditingController _startAtController;
  late final TextEditingController _endAtController;

  @override
  void initState() {
    super.initState();
    _startAtController = TextEditingController(
      text: DateHelper.formatDateSlashSeparated(
          widget.editGymChallengePageArguments.gymChallenge.startAt),
    );
    _endAtController = TextEditingController(
      text: DateHelper.formatDateSlashSeparated(
          widget.editGymChallengePageArguments.gymChallenge.endAt),
    );
  }

  @override
  void dispose() {
    _startAtController.dispose();
    _endAtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit challenge'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Save'),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacings.horizontalPadding.toDouble(),
          ),
          child: ListView(
            children: [
              BlocBuilder<EditGymChallengePageCubit, EditGymChallengePageState>(
                bloc: context.read<EditGymChallengePageCubit>(),
                buildWhen: (previous, current) =>
                    previous.image != current.image,
                builder: (context, state) {
                  return ImageBannerForm(
                    imageUrl: state.imageUrl,
                    onTap: () {},
                    image: state.image,
                  );
                },
              ),
              TextFormField(
                initialValue:
                    widget.editGymChallengePageArguments.gymChallenge.name,
                onChanged: (value) {
                  context.read<EditGymChallengePageCubit>().updateName(value);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Challenge name')),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                onChanged: (value) {
                  context
                      .read<EditGymChallengePageCubit>()
                      .updateDescription(value);
                },
                initialValue: widget
                    .editGymChallengePageArguments.gymChallenge.description,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Description (optional)')),
              ),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<EditGymChallengePageCubit, EditGymChallengePageState>(
                bloc: context.read<EditGymChallengePageCubit>(),
                buildWhen: (previous, current) =>
                    previous.startAt != current.startAt,
                builder: (context, state) {
                  return TextFormField(
                    // initialValue: DateHelper.formatDateSlashSeparated(
                    //   widget.editGymChallengePageArguments.gymChallenge.startAt,
                    // ),
                    controller: _startAtController,
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: state.startAt,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          Duration(
                            days: 365,
                          ),
                        ),
                      );
                      if (date == null) return;
                      _startAtController.text =
                          DateHelper.formatDateSlashSeparated(date);

                      // // ignore: use_build_context_synchronously
                      // _startAtController.text =
                      //     context.read<CreateChallengePageCubit>().formatDate(date);
                      // // ignore: use_build_context_synchronously
                      if (!context.mounted) return;
                      context
                          .read<EditGymChallengePageCubit>()
                          .updateStartAt(date);
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      border: OutlineInputBorder(),
                      label: Text('Start date'),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<EditGymChallengePageCubit, EditGymChallengePageState>(
                bloc: context.read<EditGymChallengePageCubit>(),
                buildWhen: (previous, current) =>
                    previous.endAt != current.endAt,
                builder: (context, state) {
                  return TextFormField(
                    // initialValue: DateHelper.formatDateSlashSeparated(
                    //   widget.editGymChallengePageArguments.gymChallenge.startAt,
                    // ),
                    controller: _endAtController,
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: state.endAt,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          Duration(
                            days: 365,
                          ),
                        ),
                      );
                      if (date == null) return;
                      _endAtController.text =
                          DateHelper.formatDateSlashSeparated(date);

                      // // ignore: use_build_context_synchronously
                      // _startAtController.text =
                      //     context.read<CreateChallengePageCubit>().formatDate(date);
                      // // ignore: use_build_context_synchronously
                      if (!context.mounted) return;
                      context
                          .read<EditGymChallengePageCubit>()
                          .updateEndAt(date);
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      border: OutlineInputBorder(),
                      label: Text('End date'),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
