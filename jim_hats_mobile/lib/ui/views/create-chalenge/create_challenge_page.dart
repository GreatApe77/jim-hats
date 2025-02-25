import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:jim_hats_mobile/ui/views/create-chalenge/cubit/create_challenge_page_cubit.dart';

class CreateChallengePage extends StatefulWidget {
  const CreateChallengePage(
      {super.key, required this.createChallengePageCubit});
  final CreateChallengePageCubit createChallengePageCubit;

  @override
  State<CreateChallengePage> createState() => _CreateChallengePageState();
}

class _CreateChallengePageState extends State<CreateChallengePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _startAtController;
  late TextEditingController _endAtController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.createChallengePageCubit.state.name);
    _descriptionController = TextEditingController(
        text: widget.createChallengePageCubit.state.description);
    _startAtController = TextEditingController(
        text: widget.createChallengePageCubit
            .formatDate(widget.createChallengePageCubit.state.startAt));

    _endAtController = TextEditingController(
        text: widget.createChallengePageCubit
            .formatDate(widget.createChallengePageCubit.state.endAt));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create challenge'),
        actions: [
          BlocConsumer<CreateChallengePageCubit, CreateChallengePageState>(
            bloc: widget.createChallengePageCubit,
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
              return TextButton(child: Text('Create'),onPressed: () => widget.createChallengePageCubit.submitForm(),);
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
                    bloc: widget.createChallengePageCubit,
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
                            // child: BlocBuilder<CreateChallengePageCubit,
                            //     CreateChallengePageState>(
                            //   bloc: widget.createChallengePageCubit,
                            //   buildWhen: (previous, current) => previous.image != current.image,
                            //   builder: (context, state) {
                            //     if (state.image != null) {
                            //       return Ink(

                            //         //: BorderRadius.circular(10),
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(10),
                            //           image: DecorationImage(
                            //             fit: BoxFit.cover,
                            //               image: FileImage(File(state.image!.path))),
                            //           //color: Theme.of(context).colorScheme.onSurface,
                            //         ),
                            //         height: 200,
                            //       );
                            //     }
                            //     return Ink(
                            //       //: BorderRadius.circular(10),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10),
                            //         color: Theme.of(context).colorScheme.onSurface,
                            //       ),
                            //       height: 200,
                            //     );
                            //   },
                            // ),
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
                          // child: BlocBuilder<CreateChallengePageCubit,
                          //     CreateChallengePageState>(
                          //   bloc: widget.createChallengePageCubit,
                          //   buildWhen: (previous, current) => previous.image != current.image,
                          //   builder: (context, state) {
                          //     if (state.image != null) {
                          //       return Ink(

                          //         //: BorderRadius.circular(10),
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(10),
                          //           image: DecorationImage(
                          //             fit: BoxFit.cover,
                          //               image: FileImage(File(state.image!.path))),
                          //           //color: Theme.of(context).colorScheme.onSurface,
                          //         ),
                          //         height: 200,
                          //       );
                          //     }
                          //     return Ink(
                          //       //: BorderRadius.circular(10),
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(10),
                          //         color: Theme.of(context).colorScheme.onSurface,
                          //       ),
                          //       height: 200,
                          //     );
                          //   },
                          // ),
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
                  widget.createChallengePageCubit
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
                onChanged: (value) => widget.createChallengePageCubit
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
                  _startAtController.text =
                      widget.createChallengePageCubit.formatDate(date);
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

  void _showMenu(BuildContext context, Offset globalPosition) {
    //final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    //final boxPosition = context.findRenderObject() as RenderBox;
    //boxPosition.localToGlobal(Offset.zero);

    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(globalPosition.dx, globalPosition.dy,
            globalPosition.dx, globalPosition.dy),
        items: [
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.image),
              title: Text('Take picture or choose from gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _takePicture();
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text('Remove image'),
              onTap: () {
                widget.createChallengePageCubit.updateImage(null);
                Navigator.of(context).pop();
              },
            ),
          )
        ]);
  }

  void _takePicture() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TakePhotoWidget(
        onPhotoChosen: (photo) {
          Navigator.of(context).pop();
          if (photo == null) return;
          widget.createChallengePageCubit.updateImage(photo);
        },
      ),
    ));
  }
}
