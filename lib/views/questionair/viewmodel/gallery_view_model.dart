import 'package:flutter/cupertino.dart';
import 'package:mhealth/viewModel/language_view_model.dart';

class GalleryViewModel extends ChangeNotifier {
  List<AttachmentModel> attachmentList;
  GalleryViewModel(this.attachmentList);

  removeImage(String fileName) {
    int index = attachmentList.indexWhere((element) => element.fileName == fileName);
    attachmentList.removeAt(index);
    notifyListeners();
  }
}
