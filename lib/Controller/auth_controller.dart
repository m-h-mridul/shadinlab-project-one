// ignore_for_file: non_constant_identifier_names

import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {

  static AuthController get to => Get.find<AuthController>();

  RxBool logoutUser = false.obs;
  String linkedin_redirectUrl =
      'https://www.linkedin.com/developers/apps/verification/2248cf72-d123-41d9-8511-9896d13f80cd';
  String linkedin_clientId = '86vkfq7kphdi79';
  String linkedin_clientSecret = 'GFeJDPQrNy6pdPfI';

}
