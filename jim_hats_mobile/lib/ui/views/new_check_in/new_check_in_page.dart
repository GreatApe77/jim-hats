import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';

class NewCheckInPage extends StatefulWidget {
  final XFile? photo;
  const NewCheckInPage({super.key, this.photo});

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
                  child: Row(
                    children: [
                      Flexible(
                          child: Container(
                              //color: Colors.red,
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
