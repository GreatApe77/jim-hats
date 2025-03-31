import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/controllers/hide_password_controller.dart';

void main() {
  late HidePasswordController sut;
  setUp(
    () {
      sut = HidePasswordController();
    },
  );
  test(
    'Should start with hidden prop as true',
    () {
      expect(sut.isHidden, isTrue);
    },
  );
  test(
    'Should start with hidden prop as false',
    () {
      expect(HidePasswordController(isHidden: false).isHidden, isFalse);
    },
  );
  test(
    'Should toggle isHidden state',
    () {
      final stateBefore = sut.isHidden;
      sut.toggle();
      final stateAfter = sut.isHidden;
      expect(stateAfter, !stateBefore);
    },
  );
  test(
    'Should notify its listeners',
    () {
      bool listenerCalled = false;
      void listener() {
        listenerCalled = true;
      }

      sut.addListener(listener);
      sut.toggle();
      sut.removeListener(listener);
      expect(listenerCalled, isTrue);
    },
  );
}
