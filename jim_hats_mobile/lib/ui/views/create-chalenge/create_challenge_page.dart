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
            SizedBox(
              height: 255,
              child: Stack(
                fit: StackFit.expand,
                
                
                children: [
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {},
                    child: Ink(
                      //: BorderRadius.circular(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      height: 200,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                )
              ]),
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
