import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class BottomNavigationComponent extends Component {
  const BottomNavigationComponent({Key? key}) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return CupertinoTabBar(
      currentIndex: 0,
      onTap: (index) {},
      items: const [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.photo)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person)),
      ],
    );
  }
}
