import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/app_drawer.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(appDrawerCubit: locator.get<AppDrawerCubit>()),
      body: Center(
        child: Text('SETTINGS ${ModalRoute.of(context)?.settings.name}'),
      ),
    );
  }
}
