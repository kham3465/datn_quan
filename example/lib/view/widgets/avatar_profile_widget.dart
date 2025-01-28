
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/app_colors.dart';

class AvatarProfileWidget extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  const AvatarProfileWidget({super.key, this.imageUrl, this.size});
  @override
  Widget build(BuildContext context) {
    return imageUrl == null ? buildDefaultAvatar() : buildImageAvatar();
  }

  Widget buildDefaultAvatar() {
    return Icon(Icons.account_circle,
        size: size ?? 36, color: AppColors.primary);
  }

  Widget buildImageAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size ?? 36),
      child: SizedBox(
        width: size ?? 36,
        height: size ?? 36,
        child: Image.asset(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, exception, stackTrace) {
            return buildDefaultAvatar();
          },
        ),
      ),
    );
  }
}
