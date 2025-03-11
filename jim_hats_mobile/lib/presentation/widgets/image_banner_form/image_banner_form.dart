import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageBannerForm extends StatelessWidget {
  final Function() onTap;
  final String imageUrl;
  final XFile? image;
  const ImageBannerForm(
      {super.key, this.image, required this.onTap, required this.imageUrl});

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
                    onTap: onTap,
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
                        onTap: onTap,
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onSurface,
                            image: DecorationImage(
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
                        onTap: onTap,
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onSurface,
                            image: DecorationImage(
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
    // return SizedBox(
    //   height: 255,
    //   child: Stack(fit: StackFit.expand, children: [
    //     BlocBuilder<CreateChallengePageCubit, CreateChallengePageState>(
    //       bloc: context.read<CreateChallengePageCubit>(),
    //       buildWhen: (previous, current) => previous.image != current.image,
    //       builder: (context, state) {
    //         if (state.image == null) {
    //           return Align(
    //             alignment: Alignment.center,
    //             child: InkWell(
    //               borderRadius: BorderRadius.circular(10),
    //               onTap: () {
    //                 _takePicture(context.read<CreateChallengePageCubit>());
    //               },
    //               child: Ink(
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                   color: Theme.of(context).colorScheme.onSurface,
    //                 ),
    //                 height: 200,
    //               ),
    //             ),
    //           );
    //         }
    //         return Align(
    //           alignment: Alignment.center,
    //           child: InkWell(
    //             borderRadius: BorderRadius.circular(10),
    //             onTapDown: (details) {
    //               _showMenu(
    //                 context,
    //                 details.globalPosition,
    //                 context.read<CreateChallengePageCubit>(),
    //               );
    //             },
    //             child: Ink(
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 image: DecorationImage(
    //                   fit: BoxFit.cover,
    //                   image: FileImage(File(state.image!.path)),
    //                 ),
    //               ),
    //               height: 200,
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //     Align(
    //       alignment: Alignment.bottomCenter,
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: CircleAvatar(
    //           backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
    //           child: Icon(Icons.camera_alt),
    //         ),
    //       ),
    //     )
    //   ]),
    // );
  }

  // void _takePicture(CreateChallengePageCubit cubit) {
  //   // Implement the picture taking logic here
  // }

  // void _showMenu(
  //     BuildContext context, Offset position, CreateChallengePageCubit cubit) {
  //   // Implement the menu showing logic here
  // }
}
