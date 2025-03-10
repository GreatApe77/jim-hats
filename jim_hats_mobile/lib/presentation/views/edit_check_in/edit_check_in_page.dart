import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/core/utils/form_validators.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/edit_check_in_page/edit_check_in_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/edit_check_in/edit_check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/gym_challenge/gym_challenge_page_arguments.dart';

class EditCheckInPage extends StatelessWidget {
  final EditCheckInPageArguments editCheckInPageArguments;
  const EditCheckInPage({super.key, required this.editCheckInPageArguments});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditCheckInPageCubit>(
      create: (context) => locator.get<EditCheckInPageCubit>(),
      child: EditCheckInView(
        editCheckInPageArguments: editCheckInPageArguments,
      ),
    );
  }
}

class EditCheckInView extends StatefulWidget {
  final EditCheckInPageArguments editCheckInPageArguments;
  const EditCheckInView({super.key, required this.editCheckInPageArguments});

  @override
  State<EditCheckInView> createState() => _EditCheckInViewState();
}

class _EditCheckInViewState extends State<EditCheckInView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Check in'),
        actions: [
          BlocConsumer<EditCheckInPageCubit, EditCheckInPageState>(
            bloc: context.read<EditCheckInPageCubit>(),
            listener: (context, state) {
              if (state.status == EditCheckInPageStatus.error) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                    ),
                  );
              } else if (state.status == EditCheckInPageStatus.success) {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.gymChallenge,
                  arguments: GymChallengePageArguments(
                    challengeId: widget
                        .editCheckInPageArguments.exerciseLog.gymChallengeId,
                  ),
                );
              }
            },
            buildWhen: (previous, current) => previous.status != current.status,
            listenWhen: (previous, current) =>
                previous.status != current.status,
            builder: (context, state) {
              if (state.status == EditCheckInPageStatus.loading) {
                return SizedBox(
                  width: 20,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return TextButton(onPressed: () {}, child: Text('Save'));
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
                initialValue: widget.editCheckInPageArguments.exerciseLog.title,
                validator: FormValidators.validateLogTitle,
                onChanged: (value) {},
                decoration: InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                initialValue: widget.editCheckInPageArguments.exerciseLog.description,
                onChanged: (value) {
                  //context.read<NewCheckInPageCubit>().updateDescription(value);
                },
                maxLines: 5,
                decoration: InputDecoration(
                  label: Text('Description (optional)'),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // BlocBuilder<EditCheckInPageCubit,EditCheckInPageState>(
              //   bloc: context.read<EditCheckInPageCubit>(),
              //   buildWhen: (previous, current) =>
              //       previous.image != current.image,
              //   builder: (context, state) {
              //     return Material(
              //       child: InkWell(
              //         borderRadius: BorderRadius.circular(10),
              //         onTap: state.image == null
              //             ?
              //             //()=>_onPhotoWidgetTap(context.read<NewCheckInPageCubit>())
              //             //_onEmptyPhotoWidgetTap
              //             //(){}
              //             () => _onPhotoWidgetTap(
              //                   context.read<NewCheckInPageCubit>(),
              //                 )
              //             : () => _onPhotoWidgetTap(
              //                   context.read<NewCheckInPageCubit>(),
              //                 ),
              //         child: SizedBox(
              //           height: 60,
              //           child: state.photo == null
              //               ? Center(
              //                   child: Row(
              //                     mainAxisSize: MainAxisSize.min,
              //                     children: [
              //                       Icon(Icons.add_photo_alternate),
              //                       SizedBox(
              //                         width: 4,
              //                       ),
              //                       Text('Add a Photo')
              //                     ],
              //                   ),
              //                 )
              //               : Row(
              //                   children: [
              //                     Flexible(
              //                         child: Container(
              //                       //color: Colors.red,
              //                       decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.only(
              //                             topLeft: Radius.circular(10),
              //                             bottomLeft: Radius.circular(10),
              //                           ),
              //                           image: DecorationImage(
              //                               fit: BoxFit.cover,
              //                               image: FileImage(
              //                                   File(state.photo!.path)))
              //                           //image: Image.file(File(widget.pageArguments.photo!.path))
              //                           ),
              //                     )),
              //                     Flexible(
              //                         flex: 4,
              //                         child: Ink(
              //                           child: Center(
              //                             child: Row(
              //                               mainAxisSize: MainAxisSize.min,
              //                               children: [
              //                                 Icon(Icons.image),
              //                                 SizedBox(
              //                                   width: 4,
              //                                 ),
              //                                 Text('Edit Media')
              //                               ],
              //                             ),
              //                           ),
              //                         )),
              //                   ],
              //                 ),
              //         ),
              //       ),
              //     );
              //   },
              // )
            ],
          ),
        ),
      )),
    );
  }
}
