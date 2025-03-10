import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/presentation/views/edit_check_in/edit_check_in_page_arguments.dart';

class EditCheckInPage extends StatelessWidget {
  final EditCheckInPageArguments editCheckInPageArguments;
  const EditCheckInPage({super.key, required this.editCheckInPageArguments});

  @override
  Widget build(BuildContext context) {
    return EditCheckInView(
      editCheckInPageArguments: editCheckInPageArguments,
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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
