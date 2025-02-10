import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
        actions: [
          TextButton(onPressed: () {
            
          }, child: Text('Post'))
        ],
      ),
    );
  }
}