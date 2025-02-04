import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'drawer_cubit_state.dart';

class DrawerCubitCubit extends Cubit<DrawerCubitState> {
  DrawerCubitCubit() : super(DrawerCubitInitial());
}
