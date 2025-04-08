import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/app.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/core/utils/date_helper.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/edit_gym_challenge_page/edit_gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/custom_page_route/custom_page_route.dart';
import 'package:jim_hats_mobile/presentation/widgets/image_banner_form/image_banner_form.dart';
import 'package:jim_hats_mobile/presentation/widgets/take_photo_widget/take_photo_widget.dart';

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
        ..updateDescription(
            editGymChallengePageArguments.gymChallenge.description)
        ..updateStartAt(editGymChallengePageArguments.gymChallenge.startAt)
        ..updateEndAt(editGymChallengePageArguments.gymChallenge.endAt)
        ..updateImageUrl(
            editGymChallengePageArguments.gymChallenge.image ?? ''),
      child: EditGymChallengeView(
        editGymChallengePageArguments: editGymChallengePageArguments,
      ),
    );
  }
}

class EditGymChallengeView extends StatefulWidget {
  final EditGymChallengePageArguments editGymChallengePageArguments;
  static const challengeNameTextFieldKey =
      Key('EditGymChallengeView.challenge_name_text_field');
  static const challengeDescriptionTextFieldKey =
      Key('EditGymChallengeView.challenge_description_text_field');
  static const saveChallengeBtnKey =
      Key('EditGymChallengeView.save_edite_challenge_btn_key');
  static const startDateTextFieldKey =
      Key('EditGymChallengeView.start_date_text_field');
  static const endDateTextFieldKey =
      Key('EditGymChallengeView.end_date_text_field');
  static const scrollableListViewKey =
      Key('EditGymChallengeView.scrollable_list_view');

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
          BlocConsumer<EditGymChallengePageCubit, EditGymChallengePageState>(
            bloc: context.read<EditGymChallengePageCubit>(),
            listener: (context, state) {
              if (state.status == EditGymChallengePageStatus.success) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.gymChallenge,
                  (route) => false,
                  arguments: GymChallengePageArguments(
                      challengeId:
                          widget.editGymChallengePageArguments.gymChallenge.id),
                );
              }
              if (state.status == EditGymChallengePageStatus.error) {
                scaffoldMessengerKey.currentState?.clearSnackBars();
                scaffoldMessengerKey.currentState?.showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    content: Text(state.errorMessage),
                  ),
                );
              }
            },
            buildWhen: (previous, current) => previous.status != current.status,
            listenWhen: (previous, current) =>
                previous.status != current.status,
            builder: (context, state) {
              return TextButton(
                key: EditGymChallengeView.saveChallengeBtnKey,
                onPressed: state.status == EditGymChallengePageStatus.loading
                    ? null
                    : () => context
                        .read<EditGymChallengePageCubit>()
                        .submitForm(
                          widget.editGymChallengePageArguments.gymChallenge.id,
                        ),
                child: Text(
                  state.status == EditGymChallengePageStatus.loading
                      ? 'Saving...'
                      : 'Save',
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacings.horizontalPadding,
          ),
          child: ListView(
            key: EditGymChallengeView.scrollableListViewKey,
            children: [
              BlocBuilder<EditGymChallengePageCubit, EditGymChallengePageState>(
                bloc: context.read<EditGymChallengePageCubit>(),
                buildWhen: (previous, current) =>
                    previous.image != current.image ||
                    previous.imageUrl != current.imageUrl,
                builder: (context, state) {
                  return ImageBannerForm(
                    imageUrl: state.imageUrl,
                    onTapDown: state.image == null && state.imageUrl.isEmpty
                        ? (details) => _changeImage(
                              context.read<EditGymChallengePageCubit>(),
                              context,
                            )
                        : (details) => _showMenu(
                              context,
                              details.globalPosition,
                              context.read<EditGymChallengePageCubit>(),
                            ),
                    image: state.image,
                  );
                },
              ),
              TextFormField(
                key: EditGymChallengeView.challengeNameTextFieldKey,
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
                key: EditGymChallengeView.challengeDescriptionTextFieldKey,
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
                    key: EditGymChallengeView.startDateTextFieldKey,
                    // initialValue: DateHelper.formatDateSlashSeparated(
                    //   widget.editGymChallengePageArguments.gymChallenge.startAt,
                    // ),
                    controller: _startAtController,
                    readOnly: true,
                    onTap: () async {
                      final initialDate = state.startAt.isBefore(DateTime.now())
                          ? DateTime.now()
                          : state.startAt;
                      final date = await showDatePicker(
                          context: context,
                          initialDate: initialDate,
                          firstDate: DateTime.now(),
                          // lastDate: DateTime.now().add(
                          //   Duration(
                          //     days: 365,
                          //   ),
                          // ),
                          lastDate: state.endAt.add(Duration(days: 365 * 2)));
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
                    key: EditGymChallengeView.endDateTextFieldKey,
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
                        lastDate: state.endAt.add(
                          Duration(days: 365 * 2),
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

  void _changeImage(EditGymChallengePageCubit cubit, BuildContext context) {
    Navigator.of(context).push(
      CustomPageRouteBuilder(
        settings: ModalRoute.of(context)?.settings,
        child: TakePhotoWidget(
          onPhotoChosen: (photo) {
            Navigator.of(context).pop();
            if (photo == null) return;
            cubit.updateImageFile(photo);
          },
        ),
      ),
    );
  }

  void _showMenu(BuildContext context, Offset globalPosition,
      EditGymChallengePageCubit cubit) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(globalPosition.dx, globalPosition.dy,
            globalPosition.dx, globalPosition.dy),
        items: [
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.image),
              title: Text('Take picture or choose from gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _changeImage(cubit, context);
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              textColor: Theme.of(context).colorScheme.error,
              leading: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text('Remove image'),
              onTap: () {
                cubit.updateImageFile(null);
                cubit.updateImageUrl('');
                Navigator.of(context).pop();
              },
            ),
          )
        ]);
  }
}
