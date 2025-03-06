import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/app.dart';
import 'package:jim_hats_mobile/presentation/cubits/internet_connectivity/cubit/internet_connectivity_cubit.dart';

class InternetCheckerWrapper extends StatelessWidget {
  final Widget child;

  const InternetCheckerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetConnectivityCubit, InternetConnectivityState>(
      bloc: context.read<InternetConnectivityCubit>(),
      listener: (context, state) {
        if (state.status == InternetConnectivityStatus.disconnected) {
          scaffoldMessengerKey.currentState?.showMaterialBanner(
            MaterialBanner(
              content: Text('No internet connection! Enable your wifi or mobile data to continue'),
              contentTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onError,
              ),
              actions: [
                SizedBox.shrink()
              ],
              leading: Icon(
                Icons.wifi_off,
                color: Theme.of(context).colorScheme.onError,
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        if (state.status == InternetConnectivityStatus.connected) {
          scaffoldMessengerKey.currentState?.clearMaterialBanners();
        }
      },
      child: child,
    );
  }
}
