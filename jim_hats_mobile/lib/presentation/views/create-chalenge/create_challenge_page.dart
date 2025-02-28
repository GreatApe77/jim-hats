import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:jim_hats_mobile/presentation/cubits/create_challenge_page/create_challenge_page_cubit.dart';

class CreateChallengePage extends StatelessWidget {
  const CreateChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateChallengePageCubit>(
      create: (context) => locator.get<CreateChallengePageCubit>(),
      child: const CreateChallengeView(),
    );
  }
}

class CreateChallengeView extends StatefulWidget {
  const CreateChallengeView({super.key});

  @override
  State<CreateChallengeView> createState() => _CreateChallengeViewState();
}

class _CreateChallengeViewState extends State<CreateChallengeView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _startAtController;
  late TextEditingController _endAtController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _nameController = TextEditingController(
          text: context.read<CreateChallengePageCubit>().state.name,
        );
        _descriptionController = TextEditingController(
          text: context.read<CreateChallengePageCubit>().state.description,
        );
        _startAtController = TextEditingController(
          text: context.read<CreateChallengePageCubit>().formatDate(
                context.read<CreateChallengePageCubit>().state.startAt,
              ),
        );

        _endAtController = TextEditingController(
          text: context.read<CreateChallengePageCubit>().formatDate(
                context.read<CreateChallengePageCubit>().state.endAt,
              ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create challenge'),
        actions: [
          BlocConsumer<CreateChallengePageCubit, CreateChallengePageState>(
            bloc: context.read<CreateChallengePageCubit>(),
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == CreateChallengePageStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    content: Text(state.errorMessage)));
              }
              if (state.status == CreateChallengePageStatus.success) {
                Navigator.of(context).pop();
              }
            },
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.status == CreateChallengePageStatus.loading) {
                return CircularProgressIndicator();
              }
              return TextButton(
                child: Text('Create'),
                onPressed: () => context.read<CreateChallengePageCubit>(),
              );
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
                height: 255,
                child: Stack(fit: StackFit.expand, children: [
                  BlocBuilder<CreateChallengePageCubit,
                      CreateChallengePageState>(
                    bloc: context.read<CreateChallengePageCubit>(),
                    buildWhen: (previous, current) =>
                        previous.image != current.image,
                    builder: (context, state) {
                      if (state.image == null) {
                        return Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              _takePicture();
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              height: 200,
                            ),
                          ),
                        );
                      }
                      return Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTapDown: (details) {
                            _showMenu(context, details.globalPosition);
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(state.image!.path)),
                              ),
                              //color: Theme.of(context).colorScheme.onSurface,
                            ),
                            height: 200,
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onInverseSurface,
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                  )
                ]),
              ),
              TextFormField(
                controller: _nameController,
                onChanged: (value) {
                  context.read<CreateChallengePageCubit>()
                      .updateName(_nameController.text);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Challenge name')),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _descriptionController,
                onChanged: (value) => context.read<CreateChallengePageCubit>()
                    .updateDescription(_descriptionController.text),
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Description (optional)')),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _startAtController,
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)));
                  if (date == null) return;
                  if(!mounted) return;
                  _startAtController.text =context.read<CreateChallengePageCubit>().formatDate(date);
                  widget.createChallengePageCubit.updateStartAt(date);
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_month),
                    border: OutlineInputBorder(),
                    label: Text('Start date')),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _endAtController,
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)));
                  if (date == null) return;
                  _endAtController.text =
                      widget.createChallengePageCubit.formatDate(date);
                  widget.createChallengePageCubit.updateEndAt(date);
                  // showDatePicker(
                  //     context: context,
                  //     initialDate: DateTime.now(),
                  //     firstDate: DateTime.now(),
                  //     lastDate: DateTime.now().add(Duration(days: 365)));
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_month),
                    border: OutlineInputBorder(),
                    label: Text('End date')),
              ),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<CreateChallengePageCubit, CreateChallengePageState>(
                bloc: widget.createChallengePageCubit,
                buildWhen: (previous, current) =>
                    previous.startAt != current.startAt ||
                    previous.endAt != current.endAt,
                builder: (context, state) {
                  return Text(
                    '${widget.createChallengePageCubit.getDayCount(state.startAt, state.endAt)} days',
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
// class CreateChallengePage extends StatefulWidget {
//   const CreateChallengePage(
//       {super.key, required this.createChallengePageCubit});
//   final CreateChallengePageCubit createChallengePageCubit;

//   @override
//   State<CreateChallengePage> createState() => _CreateChallengePageState();
// }

// class _CreateChallengePageState extends State<CreateChallengePage> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   late TextEditingController _descriptionController;
//   late TextEditingController _startAtController;
//   late TextEditingController _endAtController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController =
//         TextEditingController(text: widget.createChallengePageCubit.state.name);
//     _descriptionController = TextEditingController(
//         text: widget.createChallengePageCubit.state.description);
//     _startAtController = TextEditingController(
//         text: widget.createChallengePageCubit
//             .formatDate(widget.createChallengePageCubit.state.startAt));

//     _endAtController = TextEditingController(
//         text: widget.createChallengePageCubit
//             .formatDate(widget.createChallengePageCubit.state.endAt));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create challenge'),
//         actions: [
//           BlocConsumer<CreateChallengePageCubit, CreateChallengePageState>(
//             bloc: widget.createChallengePageCubit,
//             listenWhen: (previous, current) =>
//                 previous.status != current.status,
//             listener: (context, state) {
//               if (state.status == CreateChallengePageStatus.error) {
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     backgroundColor: Theme.of(context).colorScheme.error,
//                     content: Text(state.errorMessage)));
//               }
//               if (state.status == CreateChallengePageStatus.success) {
//                 Navigator.of(context).pop();
//               }
//             },
//             buildWhen: (previous, current) => previous.status != current.status,
//             builder: (context, state) {
//               if (state.status == CreateChallengePageStatus.loading) {
//                 return CircularProgressIndicator();
//               }
//               return TextButton(child: Text('Create'),onPressed: () => widget.createChallengePageCubit.submitForm(),);
//             },
//           )
//         ],
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: AppSpacings.horizontalPadding.toDouble()),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               SizedBox(
//                 height: 255,
//                 child: Stack(fit: StackFit.expand, children: [
//                   BlocBuilder<CreateChallengePageCubit,
//                       CreateChallengePageState>(
//                     bloc: widget.createChallengePageCubit,
//                     buildWhen: (previous, current) =>
//                         previous.image != current.image,
//                     builder: (context, state) {
//                       if (state.image == null) {
//                         return Align(
//                           alignment: Alignment.center,
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(10),
//                             onTap: () {
//                               _takePicture();
//                             },
//                             child: Ink(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Theme.of(context).colorScheme.onSurface,
//                               ),
//                               height: 200,
//                             ),
                           
//                           ),
//                         );
//                       }
//                       return Align(
//                         alignment: Alignment.center,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(10),
//                           onTapDown: (details) {
//                             _showMenu(context, details.globalPosition);
//                           },
//                           child: Ink(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: FileImage(File(state.image!.path)),
//                               ),
//                               //color: Theme.of(context).colorScheme.onSurface,
//                             ),
//                             height: 200,
//                           ),
                        
//                         ),
//                       );
//                     },
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CircleAvatar(
//                         backgroundColor:
//                             Theme.of(context).colorScheme.onInverseSurface,
//                         child: Icon(Icons.camera_alt),
//                       ),
//                     ),
//                   )
//                 ]),
//               ),
//               TextFormField(
//                 controller: _nameController,
//                 onChanged: (value) {
//                   widget.createChallengePageCubit
//                       .updateName(_nameController.text);
//                 },
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     label: Text('Challenge name')),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                 controller: _descriptionController,
//                 onChanged: (value) => widget.createChallengePageCubit
//                     .updateDescription(_descriptionController.text),
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     label: Text('Description (optional)')),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                 controller: _startAtController,
//                 onTap: () async {
//                   final date = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime.now().add(Duration(days: 365)));
//                   if (date == null) return;
//                   _startAtController.text =
//                       widget.createChallengePageCubit.formatDate(date);
//                   widget.createChallengePageCubit.updateStartAt(date);
//                 },
//                 decoration: InputDecoration(
//                     suffixIcon: Icon(Icons.calendar_month),
//                     border: OutlineInputBorder(),
//                     label: Text('Start date')),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                 controller: _endAtController,
//                 onTap: () async {
//                   final date = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime.now().add(Duration(days: 365)));
//                   if (date == null) return;
//                   _endAtController.text =
//                       widget.createChallengePageCubit.formatDate(date);
//                   widget.createChallengePageCubit.updateEndAt(date);
//                   // showDatePicker(
//                   //     context: context,
//                   //     initialDate: DateTime.now(),
//                   //     firstDate: DateTime.now(),
//                   //     lastDate: DateTime.now().add(Duration(days: 365)));
//                 },
//                 decoration: InputDecoration(
//                     suffixIcon: Icon(Icons.calendar_month),
//                     border: OutlineInputBorder(),
//                     label: Text('End date')),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               BlocBuilder<CreateChallengePageCubit, CreateChallengePageState>(
//                 bloc: widget.createChallengePageCubit,
//                 buildWhen: (previous, current) =>
//                     previous.startAt != current.startAt ||
//                     previous.endAt != current.endAt,
//                 builder: (context, state) {
//                   return Text(
//                     '${widget.createChallengePageCubit.getDayCount(state.startAt, state.endAt)} days',
//                     style: Theme.of(context).textTheme.titleLarge,
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }

//   void _showMenu(BuildContext context, Offset globalPosition) {
//     //final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
//     //final boxPosition = context.findRenderObject() as RenderBox;
//     //boxPosition.localToGlobal(Offset.zero);

//     showMenu(
//         context: context,
//         position: RelativeRect.fromLTRB(globalPosition.dx, globalPosition.dy,
//             globalPosition.dx, globalPosition.dy),
//         items: [
//           PopupMenuItem(
//             child: ListTile(
//               leading: Icon(Icons.image),
//               title: Text('Take picture or choose from gallery'),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 _takePicture();
//               },
//             ),
//           ),
//           PopupMenuItem(
//             child: ListTile(
//               textColor: Theme.of(context).colorScheme.error,
//               leading: Icon(Icons.close,color: Theme.of(context).colorScheme.error,),
//               title: Text('Remove image'),
//               onTap: () {
//                 widget.createChallengePageCubit.updateImage(null);
//                 Navigator.of(context).pop();
//               },
//             ),
//           )
//         ]);
//   }

//   void _takePicture() {
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => TakePhotoWidget(
//         onPhotoChosen: (photo) {
//           Navigator.of(context).pop();
//           if (photo == null) return;
//           widget.createChallengePageCubit.updateImage(photo);
//         },
//       ),
//     ));
//   }
// }
