// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/ui/views/new_check_in/new_check_in_page_arguments.dart';

class NewCheckInPage extends StatefulWidget {
  final NewCheckInPageArguments pageArguments;
  const NewCheckInPage({
    super.key,
    required this.pageArguments,
  });

  @override
  State<NewCheckInPage> createState() => _NewCheckInPageState();
}

class _NewCheckInPageState extends State<NewCheckInPage> {
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
        child: ListView(
          children: [
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                  label: Text('Title'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                  label: Text('Description (optional)'),
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 16,
            ),
            Material(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: SizedBox(
                  height: 60,
                  child: widget.pageArguments.photo == null
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
                                      image: FileImage(File(
                                          widget.pageArguments.photo!.path)))
                                  //image: Image.file(File(widget.pageArguments.photo!.path))
                                  ),
                            )),
                            Flexible(
                                flex: 4,
                                child: Ink(
                                  child: Container(
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
                                  ),
                                )),
                          ],
                        ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
