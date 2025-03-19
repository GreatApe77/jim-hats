import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageBannerForm extends StatelessWidget {
  final Function(TapDownDetails details) onTapDown;
  final String imageUrl;
  final XFile? image;
  const ImageBannerForm(
      {super.key, this.image, required this.onTapDown, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 255,
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageUrl.isEmpty && image == null
              ? Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTapDown: onTapDown,
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      height: 200,
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Theme.of(context).colorScheme.onInverseSurface,
                        ),
                      ),
                    ),
                  ),
                )
              : image != null
                  ? Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTapDown: onTapDown,
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onSurface,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(image!.path),
                              ),
                            ),
                          ),
                          height: 200,
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTapDown: onTapDown,
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onSurface,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                imageUrl,
                              ),
                            ),
                          ),
                          height: 200,
                        ),
                      ),
                    ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                child: Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
