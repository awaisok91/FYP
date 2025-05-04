import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidget;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOulined;
  final IconData? icon;
  final bool isLoading;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidget = true,
    this.height = 55,
    this.backgroundColor,
    this.textColor,
    this.isOulined = false,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
        width: isFullWidget ? double.infinity : null,
        height: height,
        child: isOulined
            ? OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: backgroundColor ?? theme.primaryColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: isLoading ? null : onPressed,
                child: _buildButtonContent(theme),
              )
            : ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: backgroundColor ?? theme.primaryColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: _buildButtonContent(theme),
              ));
  }

  Widget _buildButtonContent(ThemeData theme) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOulined ? theme.primaryColor : Colors.white,
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: isOulined
                ? (backgroundColor ?? theme.primaryColor)
                : (textColor ?? Colors.white),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: isOulined
                ? (backgroundColor ?? theme.primaryColor)
                : (textColor ?? Colors.white),
            fontSize: 16,
            // fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
