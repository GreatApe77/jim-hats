import 'dart:io';

import 'package:flutter/material.dart';
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
  static const nameTextFieldKey = Key('CreateChallengeView.name_text_field');
  static const descriptionTextFieldKey =
      Key('CreateChallengeView.description_text_field');
  static const startAtTextFieldKey =
      Key('CreateChallengeView.start_at_text_field');
  static const endAtTextFieldKey = Key('CreateChallengeView.end_at_text_field');
  static const createChallengeBtnKey =
      Key('CreateChallengeView.create_challenge_btn');
  static const imageInkKey = Key('CreateChallengeView.image_ink');
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    content: Text(state.errorMessage),
                  ),
                );
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
                key: CreateChallengeView.createChallengeBtnKey,
                child: Text('Create'),
                onPressed: () {
                  context.read<CreateChallengePageCubit>().submitForm();
                },
              );
            },
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppSpacings.horizontalPadding),
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
                              _takePicture(
                                  context.read<CreateChallengePageCubit>());
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
                            _showMenu(
                              context,
                              details.globalPosition,
                              context.read<CreateChallengePageCubit>(),
                            );
                          },
                          child: Ink(
                            key: CreateChallengeView.imageInkKey,
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
                key: CreateChallengeView.nameTextFieldKey,
                controller: _nameController,
                onChanged: (value) {
                  context
                      .read<CreateChallengePageCubit>()
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
                key: CreateChallengeView.descriptionTextFieldKey,
                controller: _descriptionController,
                onChanged: (value) => context
                    .read<CreateChallengePageCubit>()
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
                key: CreateChallengeView.startAtTextFieldKey,
                controller: _startAtController,
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)));
                  if (date == null) return;
                  if (!mounted) return;
                  // ignore: use_build_context_synchronously
                  _startAtController.text =
                      context.read<CreateChallengePageCubit>().formatDate(date);
                  // ignore: use_build_context_synchronously
                  context.read<CreateChallengePageCubit>().updateStartAt(date);
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
                key: CreateChallengeView.endAtTextFieldKey,
                controller: _endAtController,
                onTap: () async {
                  final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)));
                  if (date == null) return;
                  if (!mounted) return;
                  _endAtController.text =
                      context.read<CreateChallengePageCubit>().formatDate(date);
                  context.read<CreateChallengePageCubit>().updateEndAt(date);
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
                bloc: context.read<CreateChallengePageCubit>(),
                buildWhen: (previous, current) =>
                    previous.startAt != current.startAt ||
                    previous.endAt != current.endAt,
                builder: (context, state) {
                  return Text(
                    '${context.read<CreateChallengePageCubit>().getDayCount(state.startAt, state.endAt)} days',
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

  void _showMenu(BuildContext context, Offset globalPosition,
      CreateChallengePageCubit createChallengePageCubit) {
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
                _takePicture(context.read<CreateChallengePageCubit>());
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              textColor: Theme.of(context).colorScheme.error,
              leading: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text('Remove image'),
              onTap: () {
                createChallengePageCubit.updateImage(null);
                Navigator.of(context).pop();
              },
            ),
          )
        ]);
  }

  void _takePicture(CreateChallengePageCubit createChallengePageCubit) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TakePhotoWidget(
        onPhotoChosen: (photo) {
          Navigator.of(context).pop();
          if (photo == null) return;
          createChallengePageCubit.updateImage(photo);
        },
      ),
    ));
  }
}
