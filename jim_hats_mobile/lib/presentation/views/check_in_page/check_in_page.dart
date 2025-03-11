import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/app.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/core/utils/date_helper.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/check_in_page/check_in_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/check_in_page/check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/edit_check_in/edit_check_in_page.dart';
import 'package:jim_hats_mobile/presentation/views/edit_check_in/edit_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/user_circle_avatar/user_circle_avatar.dart';

class CheckInPage extends StatelessWidget {
  final CheckInPageArguments checkInPageArguments;

  const CheckInPage({super.key, required this.checkInPageArguments});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckInPageCubit>(
      create: (context) => locator.get<CheckInPageCubit>(),
      child: CheckInView(
        checkInPageArguments: checkInPageArguments,
      ),
    );
  }
}

class CheckInView extends StatelessWidget {
  final CheckInPageArguments checkInPageArguments;
  const CheckInView({super.key, required this.checkInPageArguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.upload)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Edit'),
                onTap: () {
                  final arguments = EditCheckInPageArguments(
                    exerciseLog: checkInPageArguments.exerciseLog,
                  );
                  Navigator.of(context).pushNamed(
                    AppRoutes.editCheckin,
                    arguments: arguments,
                  );
                },
              ),
              PopupMenuItem(
                child: Text(
                  'Remove check-in',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onTap: () {
                  final cubit = context.read<CheckInPageCubit>();
                  showDialog(
                    context: context,
                    builder: (context) =>
                        BlocConsumer<CheckInPageCubit, CheckInPageState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is CheckInPageSuccess) {
                          Navigator.of(context).pushReplacementNamed(
                            AppRoutes.gymChallenge,
                            arguments: GymChallengePageArguments(
                                challengeId: checkInPageArguments
                                    .exerciseLog.gymChallengeId),
                          );
                        }
                        if (state is CheckInPageError) {
                          scaffoldMessengerKey.currentState
                            ?..clearSnackBars()
                            ..showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                                content: Text(state.errorMessage),
                              ),
                            );
                        }
                      },
                      builder: (context, state) {
                        return AlertDialog(
                          title: Text('Are you sure yo want to delete?'),
                          content: Text('This action cannot be reversed.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    Theme.of(context).colorScheme.error,
                              ),
                              onPressed: state is CheckInPageLoading
                                  ? null
                                  : () {
                                      cubit.deleteCheckIn(
                                          challengeId: checkInPageArguments
                                              .exerciseLog.gymChallengeId,
                                          exerciseLogId: checkInPageArguments
                                              .exerciseLog.id);
                                    },
                              child: Text(
                                state is CheckInPageLoading
                                    ? 'Deleting...'
                                    : 'Delete',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                  // context.read<CheckInPageCubit>().deleteCheckIn(
                  //       challengeId:
                  //           checkInPageArguments.exerciseLog.gymChallengeId,
                  //       exerciseLogId: checkInPageArguments.exerciseLog.id,
                  //     );
                },
              ),
            ],
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSpacings.horizontalPadding.toDouble()),
        child: SafeArea(
            child: ListView(
          children: [
            checkInPageArguments.exerciseLog.image == null
                ? Container(
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.surfaceBright),
                    child: Center(
                      child: Icon(
                        Icons.image,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 50,
                      ),
                    ))
                : Container(
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(
                                checkInPageArguments.exerciseLog.image!))),
                  ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(checkInPageArguments.exerciseLog.user.username),
              subtitle: Text(DateHelper.formatDateExtended(
                  checkInPageArguments.exerciseLog.date)),
              leading: UserCircleAvatar(
                username: checkInPageArguments.exerciseLog.user.username,
                avatarUrl: checkInPageArguments.exerciseLog.user.profilePicture,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                checkInPageArguments.exerciseLog.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            checkInPageArguments.exerciseLog.description == null
                ? SizedBox.shrink()
                : Text(
                    checkInPageArguments.exerciseLog.description!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
          ],
        )),
      ),
    );
  }
}
