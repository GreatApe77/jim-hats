import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';

class CreateChallengePage extends StatelessWidget {
  const CreateChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create challenge'),
        actions: [TextButton(onPressed: () {}, child: Text('Next'))],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSpacings.horizontalPadding.toDouble()),
        child: ListView(
          children: [
            ClipRRect(
              
              borderRadius: BorderRadius.circular(20),
              child: Container(
                child: InkWell(),
                height: 100,
                color: Colors.red,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Challenge name')),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Description (optional)')),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                  label: Text('Start date')),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                  label: Text('End date')),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              '1500 days',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      )),
    );
  }
}
