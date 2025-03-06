import 'package:flutter/material.dart';

class UserCircleAvatar extends StatefulWidget {
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
  State<UserCircleAvatar> createState() => _UserCircleAvatarState();
}

class _UserCircleAvatarState extends State<UserCircleAvatar> {
  ValueNotifier<bool> failedToLoadImage = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: failedToLoadImage,
      builder: (context, child) {
        if (widget.avatarUrl == null || failedToLoadImage.value) {
          return CircleAvatar(
            radius: widget.radius,
            child: Text(
              '${widget.username[0]}${widget.username[1]}'.toUpperCase(),
              style: TextStyle(fontSize: widget.radius),
            ),
          );
        }
        return CircleAvatar(
          radius: widget.radius,
          backgroundImage: NetworkImage(widget.avatarUrl!),
          onBackgroundImageError: (__, _) {
            failedToLoadImage.value = true;
          },
        );
      },
    );
  }
}
