import 'package:flutter/material.dart';
import 'package:socialcommerce/utils/constants.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool fullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderSide? side;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.side,
    this.borderRadius = 28,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.primary;
    final fgColor = textColor ?? Colors.white;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: side ?? BorderSide.none,
          ),
          elevation: 0,
          textStyle: AppTextStyles.title.copyWith(color: fgColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 10),
            ],
            Text(label),
          ],
        ),
      ),
    );
  }
}
