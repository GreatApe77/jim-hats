// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:jim_hats_mobile/ui/views/new_check_in/cubit/check_in_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/new_check_in/new_check_in_page_arguments.dart';

class NewCheckInPage extends StatefulWidget {
  final NewCheckInPageArguments pageArguments;
  final NewCheckInPageCubit checkInPageCubit;
  const NewCheckInPage({
    super.key,
    required this.pageArguments,
    required this.checkInPageCubit,
  });

  @override
  State<NewCheckInPage> createState() => _NewCheckInPageState();
}

class _NewCheckInPageState extends State<NewCheckInPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New check-in'),
        actions: [TextButton(onPressed: () {}, child: Text('Post'))],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSpacings.horizontalPadding.toDouble()),
        child: Form(
          child: ListView(
            children: [
              SizedBox(
                height: 16,
              ),
              TextFormField(
                onChanged: (value) {
                  widget.checkInPageCubit.updateTitle(value);
                },
                decoration: InputDecoration(
                    label: Text('Title'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                onChanged: (value) {
                  widget.checkInPageCubit.updateDescription(value);
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
                bloc: widget.checkInPageCubit,
                buildWhen: (previous, current) =>
                    previous.photo != current.photo,
                builder: (context, state) {
                  return Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: state.photo == null ? _onEmptyPhotoWidgetTap : _onPhotoWidgetTap,
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

  void _onPhotoWidgetTap() {
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
                  _choosePhoto();
                },
                title: Text('Update photo'),
                leading: Icon(Icons.image),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  widget.checkInPageCubit.updateImage(null);
                },
                title: Text(
                  'Remove photo',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                leading: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onEmptyPhotoWidgetTap() {
    _choosePhoto();
  }

  void _choosePhoto() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TakePhotoWidget(
        onPhotoChosen: (photo) {
          Navigator.of(context).pop();
          if (photo == null) return;
          widget.checkInPageCubit.updateImage(photo);
        },
      ),
    ));
  }
}
