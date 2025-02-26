import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/app_drawer.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/ui/views/user_stats/cubit/user_stats_cubit.dart';

class UserStatsPage extends StatefulWidget {
  final UserStatsCubit userStatsCubit;
  const UserStatsPage({super.key, required this.userStatsCubit});

  @override
  State<UserStatsPage> createState() => _UserStatsPageState();
}

class _UserStatsPageState extends State<UserStatsPage> {
  @override
  void initState() {
    super.initState();
    widget.userStatsCubit.loadUserStatsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(appDrawerCubit: locator.get<AppDrawerCubit>()),
      body: BlocBuilder<UserStatsCubit, UserStatsState>(
        bloc: widget.userStatsCubit,
        builder: (context, state) {
          if (state is UserStatsInitial) {
            return SizedBox.shrink();
          }
          if (state is UserStatsDataLoadInProgess) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UsersStatsDataSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacings.horizontalPadding.toDouble()),
              child: SafeArea(
                  child: ListView(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.loggedUser.profilePicture ?? ''),
                        radius: 50,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        state.loggedUser.username,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StatsItem(label: 'Check-inst', value: '0'),
                        ],
                      ),
                    ],
                  )
                ],
              )),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

class StatsItem extends StatelessWidget {
  final String label;
  final String value;
  const StatsItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
