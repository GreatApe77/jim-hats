import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/widgets/app_drawer/app_drawer.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/home_page/home_page_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
      create: (context) => locator.get<HomePageCubit>()..loadData(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(appDrawerCubit: locator.get<AppDrawerCubit>()),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        bloc: context.read<HomePageCubit>(),
        builder: (context, state) {
          if (state is HomePageDataLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomePageDataSuccess) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hello, ${state.loggedUser.username}',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    'Check the menu for your challenges',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
