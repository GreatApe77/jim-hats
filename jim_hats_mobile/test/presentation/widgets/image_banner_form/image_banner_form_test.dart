import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/presentation/widgets/image_banner_form/image_banner_form.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Should display no image state', (tester) async {
    mockNetworkImagesFor(
      () async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ImageBannerForm(
                onTapDown: (details) {},
                imageUrl: '',
              ),
            ),
          ),
        );
        expect(find.byIcon(Icons.image), findsOneWidget);
        expect(find.byIcon(Icons.camera_alt), findsOneWidget);
      },
    );
  });
  testWidgets('Should display http image', (tester) async {
    mockNetworkImagesFor(
      () async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ImageBannerForm(
                onTapDown: (details) {},
                imageUrl: 'https://image.com',

                //       image: XFile(''),
              ),
            ),
          ),
        );
        expect(find.byIcon(Icons.image), findsNothing);
        //ImageBannerForm.file_image_inkwell
        expect(find.byKey(Key('ImageBannerForm.network_image_ink_well')),
            findsOne);
        expect(find.byIcon(Icons.camera_alt), findsOneWidget);
      },
    );
  });

  testWidgets('Should display file image', (tester) async {
    mockNetworkImagesFor(
      () async {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ImageBannerForm(
                onTapDown: (details) {},
                imageUrl: '',
                image: XFile('any'),
                //       image: XFile(''),
              ),
            ),
          ),
        );
        expect(find.byIcon(Icons.image), findsNothing);
        //ImageBannerForm.file_image_inkwell
        expect(find.byKey(Key('ImageBannerForm.file_image_inkwell')), findsOne);
        expect(find.byIcon(Icons.camera_alt), findsOneWidget);
      },
    );
  });
}
