import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker imgpicker = ImagePicker();
RxList<XFile>? imagefiles = RxList<XFile>();

openImages() async {
  try {
    var pickedfiles = await imgpicker.pickMultiImage();
    //you can use ImageCourse.camera for Camera capture
    if (pickedfiles != null) {
      imagefiles!.clear();
      List<XFile>? imagelist = pickedfiles;
      imagefiles!.value.addAll(imagelist);
      imagefiles!.refresh();
    } else {
      print("No image is selected.");
    }
  } catch (e) {
    print("error while picking file.");
  }
}
