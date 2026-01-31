import 'package:flutter/material.dart';
import 'package:helper_extensions/extensions/color_utilities.dart';
import '../../core/theme/app_colors.dart';

// Reusable user avatar widget
class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    this.imageUrl,
    this.size = 48,
    this.showBorder = false,
    this.borderColor = AppColors.primary,
    this.borderWidth = 2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.applyOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return placeholder();
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return loading();
                },
              )
            : placeholder(),
      ),
    );

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }

  Widget placeholder() {
    return Container(
      color: AppColors.primaryLight.applyOpacity(0.3),
      child: Icon(Icons.person, size: size * 0.5, color: AppColors.primary),
    );
  }

  Widget loading() {
    return Container(
      color: AppColors.primaryLight.applyOpacity(0.2),
      child: Center(
        child: SizedBox(
          width: size * 0.3,
          height: size * 0.3,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
