import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/presentation/cubits/internet_connectivity/cubit/internet_connectivity_cubit.dart';

class InternetCheckerWrapper extends StatelessWidget {
  final Widget child;

  const InternetCheckerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetConnectivityCubit, InternetConnectivityState>(
      bloc: context.read<InternetConnectivityCubit>(),
      listener: (context, state) {
        print(hashCode);
        if (state.status == InternetConnectivityStatus.disconnected) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error,
              duration: Duration(
                days: 1,
              ),
              content: Row(
                children: [
                  Icon(
                    Icons.wifi_off,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'No internet connection',
                  ),
                ],
              ),
            ),
          );
        }
        if (state.status == InternetConnectivityStatus.connected) {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      child: child,
    );
  }
}
