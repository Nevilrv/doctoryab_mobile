import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/AppColors.dart';

class StoryAvatar extends StatelessWidget {
  const StoryAvatar({
    Key? key,
    required this.assetPath,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);
  final String assetPath;
  final bool isActive;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        width: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isActive ? AppColors.gradient : null,
            color: !isActive ? AppColors.grey.withOpacity(0.3) : null),
        child: Container(
          height: 64 - 3.9,
          width: 64 - 3.9,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                image: CachedNetworkImageProvider(assetPath),
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
