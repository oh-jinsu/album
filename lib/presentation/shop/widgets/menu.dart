import 'package:flutter/cupertino.dart';

class ShopMenu extends StatelessWidget {
  final bool isPending;
  final void Function() onPressed;
  final String label;
  final String price;

  const ShopMenu({
    Key? key,
    required this.isPending,
    required this.onPressed,
    required this.label,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      padding: const EdgeInsets.only(
        top: 12.0,
        bottom: 12.0,
        left: 16.0,
        right: 8.0,
      ),
      prefix: Row(
        children: [
          Text("🌁 " + label),
        ],
      ),
      child: CupertinoButton(
        color: CupertinoColors.systemGroupedBackground,
        minSize: 28.0,
        borderRadius: BorderRadius.circular(32.0),
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
        ),
        child: SizedBox(
          width: 84.0,
          child: Center(
            child: isPending
                ? const CupertinoActivityIndicator(
                    color: CupertinoColors.activeBlue,
                  )
                : Text(
                    price,
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: CupertinoColors.activeBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
