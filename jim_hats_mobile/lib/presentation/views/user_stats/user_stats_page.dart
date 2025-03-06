import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/user_stats_page/user_stats_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/user_stats/widgets/stats_item.dart';
import 'package:jim_hats_mobile/presentation/widgets/app_drawer/app_drawer.dart';

class UserStatsPage extends StatelessWidget {
  const UserStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserStatsCubit>(
      create: (context) => locator.get<UserStatsCubit>()..loadUserStatsData(),
      child: const _UserStatsView(),
    );
  }
}

class _UserStatsView extends StatelessWidget {
  const _UserStatsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(appDrawerCubit: locator.get<AppDrawerCubit>()),
      body: BlocBuilder<UserStatsCubit, UserStatsState>(
        bloc: context.read<UserStatsCubit>(),
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
                          StatsItem(
                            label: 'Check-ins',
                            value: state.logsOfUser.length.toString(),
                          ),
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