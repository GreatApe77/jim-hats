import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/ui/views/check_in_page/check_in_page_arguments.dart';

class CheckInPage extends StatelessWidget {
  final CheckInPageArguments checkInPageArguments;
  const CheckInPage({super.key, required this.checkInPageArguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.upload)),
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.more_vert))
        ],
        
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacings.horizontalPadding.toDouble()
        ),
        child: SafeArea(child: ListView(
          children: [
            checkInPageArguments.exerciseLog.image==null?
            
            Container(
              height: 300,
              decoration:
              BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surfaceBright
              ),
              child: Center(
                child: Icon(Icons.image,color: Theme.of(context).colorScheme.onSurface,size:50,),
              )
              
            ):Container(
              height: 300,

              decoration: BoxDecoration(
                
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(checkInPageArguments.exerciseLog.image!))
              ),
            )
          ],
        )),
      ),
    );
  }
}