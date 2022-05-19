import 'package:album/application/effects/album/submit_form.dart';
import 'package:album/application/events/album/form_submitted.dart';
import 'package:album/application/events/album/form_title_changed.dart';
import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/models/album/form.dart';
import 'package:album/application/models/common/state.dart';
import 'package:album/application/stores/album_form.dart';
import 'package:codux/codux.dart';
import 'package:flutter/cupertino.dart';

class AddAlbumDialog extends Component {
  const AddAlbumDialog({Key? key}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => AlbumFormStore());
    useEffect(() => SubmitAlbumFormEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return StreamBuilder(
      stream: find<AlbumFormStore>().stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as AlbumFormModel;

          return CupertinoAlertDialog(
            title: const Text("새로운 앨범 추가하기"),
            content: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CupertinoTextField(
                    autofocus: true,
                    enabled: data.state != SubmitFormState.pending,
                    placeholder: "앨범의 제목을 입력해 주세요.",
                    clearButtonMode: OverlayVisibilityMode.editing,
                    placeholderStyle: const TextStyle(
                      color: CupertinoColors.systemGrey4,
                      height: 1.1,
                    ),
                    onChanged: (v) => dispatch(AlbumFormTitleChanged(v)),
                  ),
                  if (data.message == null)
                    const SizedBox(height: 4.0)
                  else
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        data.message!,
                        style: const TextStyle(
                          color: CupertinoColors.destructiveRed,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            actions: [
              CupertinoButton(
                onPressed: () {
                  if (data.state == SubmitFormState.pending) {
                    return;
                  }

                  dispatch(const Popped());
                },
                child: const Text(
                  "취소",
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
              if (data.state == SubmitFormState.enabled)
                CupertinoButton(
                  onPressed: () => dispatch(
                    AlbumFormSumitted(
                      title: data.title,
                    ),
                  ),
                  child: const Text("추가"),
                )
              else if (data.state == SubmitFormState.pending)
                CupertinoButton(
                  onPressed: () {},
                  child: const CupertinoActivityIndicator(),
                )
              else
                CupertinoButton(
                  onPressed: () {},
                  child: const Text(
                    "추가",
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                )
            ],
          );
        }

        return Container();
      },
    );
  }
}
