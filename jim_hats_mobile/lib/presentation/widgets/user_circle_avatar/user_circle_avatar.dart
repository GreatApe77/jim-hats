import 'package:flutter/material.dart';

class UserCircleAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String username;
  final double? radius;
  const UserCircleAvatar({
    super.key,
    this.avatarUrl,
    required this.username,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    if (avatarUrl == null) {
      return CircleAvatar(
        radius: radius,
        child: Text('${username[0]}${username[1]}'.toUpperCase(),style: TextStyle(
          fontSize: radius
        ),),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(avatarUrl!),
    );
  }
}
