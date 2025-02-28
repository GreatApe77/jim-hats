// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/core/utils/form_validators.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/new_check_in_page/new_check_in_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/new_check_in/new_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/take_photo_widget/take_photo_widget.dart';

class NewCheckInPage extends StatelessWidget {
  final NewCheckInPageArguments pageArguments;
  const NewCheckInPage({
    super.key,
    required this.pageArguments,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewCheckInPageCubit>(
      create: (context) =>
          locator.get<NewCheckInPageCubit>()..updateImage(pageArguments.photo),
      child: NewCheckInView(
        pageArguments: pageArguments,
      ),
    );
  }
}

class NewCheckInView extends StatefulWidget {
  final NewCheckInPageArguments pageArguments;
  const NewCheckInView({super.key, required this.pageArguments});

  @override
  State<NewCheckInView> createState() => _NewCheckInViewState();
}

class _NewCheckInViewState extends State<NewCheckInView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New check-in'),
        actions: [
          BlocConsumer<NewCheckInPageCubit, NewCheckInPageState>(
            bloc: context.read<NewCheckInPageCubit>(),
            listener: (context, state) {
              if (state.status == NewCheckInPageStatus.failed) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                      SnackBar(content: Text('Error while posting exercise')));
              } else if (state.status == NewCheckInPageStatus.success) {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.gymChallenge,
                  arguments: GymChallengePageArguments(
                    challengeId: widget.pageArguments.challengeId,
                  ),
                );
              }
            },
            buildWhen: (previous, current) => previous.status != current.status,
            listenWhen: (previous, current) =>
                previous.status != current.status,
            builder: (context, state) {
              if (state.status == NewCheckInPageStatus.loading) {
                return SizedBox(
                  width: 20,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return TextButton(
                  onPressed: () => _submitForm(
                        context.read<NewCheckInPageCubit>(),
                      ),
                  child: Text('Post'));
            },
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSpacings.horizontalPadding.toDouble()),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 16,
              ),
              TextFormField(
                validator: FormValidators.validateLogTitle,
                onChanged: (value) {
                  context.read<NewCheckInPageCubit>().updateTitle(value);
                },
                decoration: InputDecoration(
                    label: Text('Title'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                onChanged: (value) {
                  context.read<NewCheckInPageCubit>().updateDescription(value);
                },
                maxLines: 5,
                decoration: InputDecoration(
                    label: Text('Description (optional)'),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<NewCheckInPageCubit, NewCheckInPageState>(
                bloc: context.read<NewCheckInPageCubit>(),
                buildWhen: (previous, current) =>
                    previous.photo != current.photo,
                builder: (context, state) {
                  return Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: state.photo == null
                          ?
                          //()=>_onPhotoWidgetTap(context.read<NewCheckInPageCubit>())
                          //_onEmptyPhotoWidgetTap
                          //(){}
                          () => _onPhotoWidgetTap(
                                context.read<NewCheckInPageCubit>(),
                              )
                          : () => _onPhotoWidgetTap(
                                context.read<NewCheckInPageCubit>(),
                              ),
                      child: SizedBox(
                        height: 60,
                        child: state.photo == null
                            ? Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.add_photo_alternate),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text('Add a Photo')
                                  ],
                                ),
                              )
                            : Row(
                                children: [
                                  Flexible(
                                      child: Container(
                                    //color: Colors.red,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                                File(state.photo!.path)))
                                        //image: Image.file(File(widget.pageArguments.photo!.path))
                                        ),
                                  )),
                                  Flexible(
                                      flex: 4,
                                      child: Ink(
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.image),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text('Edit Media')
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  void _onPhotoWidgetTap(NewCheckInPageCubit newCheckInPageCubit) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSpacings.horizontalPadding.toDouble()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Photo Selection',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ListTile(
                onTap: () {
                  _choosePhoto(newCheckInPageCubit);
                },
                title: Text('Update photo'),
                leading: Icon(Icons.image),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onEmptyPhotoWidgetTap(NewCheckInPageCubit newCheckInPageCubit) {
    _choosePhoto(newCheckInPageCubit);
  }

  void _choosePhoto(NewCheckInPageCubit newCheckInPageCubit) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TakePhotoWidget(
        onPhotoChosen: (photo) {
          Navigator.of(context).pop();
          if (photo == null) return;
          newCheckInPageCubit.updateImage(photo);
        },
      ),
    ));
  }

  void _submitForm(NewCheckInPageCubit newCheckInPageCubit) {
    if (!_formKey.currentState!.validate()) return;
    newCheckInPageCubit.submitForm(widget.pageArguments.challengeId);
  }
}

// class NewCheckInPage extends StatefulWidget {
//   final NewCheckInPageArguments pageArguments;
//   final NewCheckInPageCubit checkInPageCubit;
//   const NewCheckInPage({
//     super.key,
//     required this.pageArguments,
//     required this.checkInPageCubit,
//   });

//   @override
//   State<NewCheckInPage> createState() => _NewCheckInPageState();
// }

// class _NewCheckInPageState extends State<NewCheckInPage> {
//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('New check-in'),
//         actions: [
//           BlocConsumer<NewCheckInPageCubit, NewCheckInPageState>(
//             bloc: widget.checkInPageCubit,
//             listener: (context, state) {
//               if (state.status == NewCheckInPageStatus.failed) {
//                 ScaffoldMessenger.of(context)
//                   ..clearSnackBars()
//                   ..showSnackBar(
//                       SnackBar(content: Text('Error while posting exercise')));
//               } else if (state.status == NewCheckInPageStatus.success) {
//                 Navigator.of(context).pushReplacementNamed(
//                     AppRoutes.gymChallenge,
//                     arguments: GymChallengePageArguments(
//                         challengeId: widget.pageArguments.challengeId));
//               }
//             },
//             buildWhen: (previous, current) => previous.status != current.status,
//             listenWhen: (previous, current) =>
//                 previous.status != current.status,
//             builder: (context, state) {
//               if (state.status == NewCheckInPageStatus.loading) {
//                 return SizedBox(
//                   width: 20,
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//               return TextButton(onPressed: _submitForm, child: Text('Post'));
//             },
//           )
//         ],
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: AppSpacings.horizontalPadding.toDouble()),
//         child: Form(
//           key: formKey,
//           child: ListView(
//             children: [
//               SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                 validator: FormValidators.validateLogTitle,
//                 onChanged: (value) {
//                   widget.checkInPageCubit.updateTitle(value);
//                 },
//                 decoration: InputDecoration(
//                     label: Text('Title'), border: OutlineInputBorder()),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                 onChanged: (value) {
//                   widget.checkInPageCubit.updateDescription(value);
//                 },
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                     label: Text('Description (optional)'),
//                     border: OutlineInputBorder()),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               BlocBuilder<NewCheckInPageCubit, NewCheckInPageState>(
//                 bloc: widget.checkInPageCubit,
//                 buildWhen: (previous, current) =>
//                     previous.photo != current.photo,
//                 builder: (context, state) {
//                   return Material(
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(10),
//                       onTap: state.photo == null
//                           ? _onEmptyPhotoWidgetTap
//                           : _onPhotoWidgetTap,
//                       child: SizedBox(
//                         height: 60,
//                         child: state.photo == null
//                             ? Center(
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(Icons.add_photo_alternate),
//                                     SizedBox(
//                                       width: 4,
//                                     ),
//                                     Text('Add a Photo')
//                                   ],
//                                 ),
//                               )
//                             : Row(
//                                 children: [
//                                   Flexible(
//                                       child: Container(
//                                     //color: Colors.red,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(10),
//                                           bottomLeft: Radius.circular(10),
//                                         ),
//                                         image: DecorationImage(
//                                             fit: BoxFit.cover,
//                                             image: FileImage(
//                                                 File(state.photo!.path)))
//                                         //image: Image.file(File(widget.pageArguments.photo!.path))
//                                         ),
//                                   )),
//                                   Flexible(
//                                       flex: 4,
//                                       child: Ink(
//                                         child: Center(
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Icon(Icons.image),
//                                               SizedBox(
//                                                 width: 4,
//                                               ),
//                                               Text('Edit Media')
//                                             ],
//                                           ),
//                                         ),
//                                       )),
//                                 ],
//                               ),
//                       ),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }

//   void _onPhotoWidgetTap() {
//     showModalBottomSheet(
//       showDragHandle: true,
//       context: context,
//       builder: (context) => SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: AppSpacings.horizontalPadding.toDouble()),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Photo Selection',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               ListTile(
//                 onTap: () {
//                   _choosePhoto();
//                 },
//                 title: Text('Update photo'),
//                 leading: Icon(Icons.image),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _onEmptyPhotoWidgetTap() {
//     _choosePhoto();
//   }

//   void _choosePhoto() {
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => TakePhotoWidget(
//         onPhotoChosen: (photo) {
//           Navigator.of(context).pop();
//           if (photo == null) return;
//           widget.checkInPageCubit.updateImage(photo);
//         },
//       ),
//     ));
//   }

//   void _submitForm() {
//     if (!formKey.currentState!.validate()) return;
//     widget.checkInPageCubit.submitForm(widget.pageArguments.challengeId);
//   }
// }
