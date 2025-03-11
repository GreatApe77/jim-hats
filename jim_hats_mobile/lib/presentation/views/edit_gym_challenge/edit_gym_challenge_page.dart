import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/core/utils/date_helper.dart';
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
    return EditGymChallengeView(
      editGymChallengePageArguments: editGymChallengePageArguments,
    );
  }
}

class EditGymChallengeView extends StatelessWidget {
  final EditGymChallengePageArguments editGymChallengePageArguments;

  const EditGymChallengeView({
    super.key,
    required this.editGymChallengePageArguments,
  });

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
              ImageBannerForm(
                onTap: () {},
                image: XFile(''),
              ),
              TextFormField(
                initialValue: editGymChallengePageArguments.gymChallenge.name,
                onChanged: (value) {
                  // context
                  //     .read<CreateChallengePageCubit>()
                  //     .updateName(_nameController.text);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Challenge name')),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                // onChanged: (value) => context
                // .read<CreateChallengePageCubit>()
                // .updateDescription(_descriptionController.text),
                initialValue:
                    editGymChallengePageArguments.gymChallenge.description,

                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Description (optional)')),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                initialValue: DateHelper.formatDateSlashSeparated(
                    editGymChallengePageArguments.gymChallenge.startAt,),
                // controller: _startAtController,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365,),),);
                  if (date == null) return;
                  // if (!mounted) return;
                  // // ignore: use_build_context_synchronously
                  // _startAtController.text =
                  //     context.read<CreateChallengePageCubit>().formatDate(date);
                  // // ignore: use_build_context_synchronously
                  // context.read<CreateChallengePageCubit>().updateStartAt(date);
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                  label: Text('Start date'),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                //controller: _endAtController,
                readOnly: true,
                initialValue: DateHelper.formatDateSlashSeparated(
                    editGymChallengePageArguments.gymChallenge.endAt,),
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)));
                  if (date == null) return;
                  // if (!mounted) return;
                  // _endAtController.text =
                  //     context.read<CreateChallengePageCubit>().formatDate(date);
                  // context.read<CreateChallengePageCubit>().updateEndAt(date);
                  // showDatePicker(
                  //     context: context,
                  //     initialDate: DateTime.now(),
                  //     firstDate: DateTime.now(),
                  //     lastDate: DateTime.now().add(Duration(days: 365)));
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_month),
                    border: OutlineInputBorder(),
                    label: Text('End date')),
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
