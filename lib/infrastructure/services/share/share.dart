import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> share(String text, {String? subject}) async {
    await Share.share(text, subject: subject);
  }
}
