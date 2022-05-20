import 'package:flutter/cupertino.dart';

class SignInDescription extends StatelessWidget {
  const SignInDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: "로그인하고 🤟\n",
            style: TextStyle(
              color: CupertinoColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          TextSpan(
            text: "소중한 추억",
            style: TextStyle(
              color: CupertinoColors.activeBlue,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          TextSpan(
            text: "을\n",
            style: TextStyle(
              color: CupertinoColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          TextSpan(
            text: "소중한 사람",
            style: TextStyle(
              color: CupertinoColors.activeBlue,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          TextSpan(
            text: "과 함께\n",
            style: TextStyle(
              color: CupertinoColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          TextSpan(
            text: "저장해 보세요.",
            style: TextStyle(
              color: CupertinoColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
        ],
      ),
    );
  }
}
