import 'package:album/application/effects/photo_form/pick_image.dart';
import 'package:album/application/effects/photo_form/submit.dart';
import 'package:album/application/events/navigation/popped.dart';
import 'package:album/application/events/photo/form_date_changed.dart';
import 'package:album/application/events/photo/form_description_changed.dart';
import 'package:album/application/events/photo/picker_tapped.dart';
import 'package:album/application/events/photo/submitted.dart';
import 'package:album/application/models/common/state.dart';
import 'package:album/application/models/photo/form.dart';
import 'package:album/application/stores/photo_form.dart';
import 'package:album/presentation/components/photo_form/widgets/container.dart';
import 'package:album/presentation/components/photo_form/widgets/date_picker.dart';
import 'package:album/presentation/components/photo_form/widgets/submit_button.dart';
import "package:codux/codux.dart";
import 'package:flutter/cupertino.dart';

class PhotoFormModal extends Component {
  final String id;

  const PhotoFormModal({Key? key, required this.id}) : super(key: key);

  @override
  void onCreated(BuildContext context) {
    useStore(() => PhotoFormStore());

    useEffect(() => PickImageEffect());
    useEffect(() => SubmitPhotoFormEffect());

    super.onCreated(context);
  }

  @override
  Widget render(BuildContext context) {
    return PhotoEditorContainer(
      onCanceled: () => dispatch(const Popped()),
      child: StreamBuilder(
        stream: find<PhotoFormStore>().stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as PhotoFormModel;

            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (data.state == SubmitFormState.pending) {
                      return;
                    }

                    dispatch(const PhotoFormImagePickerTapped());
                  },
                  child: Container(
                    color: CupertinoColors.quaternarySystemFill,
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: data.file != null
                          ? Image(
                              fit: BoxFit.cover,
                              image: FileImage(data.file!),
                            )
                          : Center(
                              child: Icon(
                                CupertinoIcons.photo_fill_on_rectangle_fill,
                                color: CupertinoTheme.of(context).primaryColor,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                PhotoEditorDatePicker(
                  onSubmitted: (v) => dispatch(PhotoFormDateChanged(v)),
                  enabled: data.state != SubmitFormState.pending,
                  date: data.date,
                ),
                const SizedBox(height: 12.0),
                CupertinoTextField(
                  clearButtonMode: OverlayVisibilityMode.editing,
                  placeholder: "기억에 남는 일이 있다면 짧은 감상을 남겨 보세요.",
                  keyboardType: TextInputType.text,
                  minLines: 3,
                  maxLines: 3,
                  enabled: data.state != SubmitFormState.pending,
                  onChanged: (v) => dispatch(PhotoFormDescriptionChanged(v)),
                ),
                const SizedBox(height: 16.0),
                PhotoEditorSubmitButton(
                  onPressed: () {
                    final file = data.file;

                    if (file == null) {
                      return;
                    }

                    final date = data.date;

                    final description = data.description;

                    dispatch(PhotoFormSubmitted(
                      albumId: id,
                      file: file,
                      date: date,
                      description: description,
                    ));
                  },
                  state: data.state,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
