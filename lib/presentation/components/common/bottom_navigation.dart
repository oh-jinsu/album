import 'package:album/application/events/navigation/replaced.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class BottomNavigationComponent extends Component {
  final int currentIndex;

  const BottomNavigationComponent({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return CupertinoTabBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            if (currentIndex == 0) {
              return;
            }
            dispatch(const Replaced("/home"));
            break;
          case 1:
            if (currentIndex == 1) {
              return;
            }
            dispatch(const Replaced("/profile"));
            break;
          default:
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.photo)),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person)),
      ],
    );
  }
}
