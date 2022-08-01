// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:shadinlab_one/services/facebook_auth.dart';
import 'package:shadinlab_one/view/screen/profileView.dart';
import '../../services/google_loginauth.dart';
import '../../services/twitter_auth.dart';
import '../../Controller/auth_controller.dart';
import '../../model/usermodel.dart';

class AuthPages extends StatelessWidget {
  AuthPages({Key? key}) : super(key: key);
  AuthController controller = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await signInWithFacebook();
                  // Get.to(() => Facebook_auth());
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text('Facebook'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  UserCredential usercredential = await signInWithGoogle();
                  UserObject user = UserObject(
                      firstName: usercredential.user!.displayName!,
                      lastName: 'for google not find',
                      email: usercredential.user!.email!,
                      profileImageUrl: usercredential.user!.photoURL!);
                  Get.to(() => ProfleUI(
                        user: user,
                      ));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text('Google'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    TwitterId usercredential = await signInWithTwitter();
                    UserObject user = UserObject(
                      firstName: usercredential.name!,
                      lastName: 'for twitter not find',
                      email: usercredential.email!,
                      profileImageUrl: usercredential.photourl!,
                    );
                    Get.to(() => ProfleUI(
                          user: user,
                        ));
                  } catch (e) {
                    print('error in twitter button ${e}');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text('Twitter'),
              ),
              const SizedBox(
                height: 20,
              ),
              LinkedInButtonStandardWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (final BuildContext context) =>
                          LinkedInUserWidget(
                        appBar: AppBar(
                          title: const Text('Auth User'),
                        ),
                        destroySession: controller.logoutUser.value,
                        redirectUrl: controller.linkedin_redirectUrl,
                        clientId: controller.linkedin_clientId,
                        clientSecret: controller.linkedin_clientSecret,
                        projection: const [
                          ProjectionParameters.id,
                          ProjectionParameters.localizedFirstName,
                          ProjectionParameters.localizedLastName,
                          ProjectionParameters.firstName,
                          ProjectionParameters.lastName,
                          ProjectionParameters.profilePicture,
                        ],
                        onError: (final UserFailedAction e) {
                          print('Error: ${e.toString()}');
                          print('Error: ${e.stackTrace.toString()}');
                        },
                        onGetUserProfile:
                            (final UserSucceededAction linkedInUser) {
                          UserObject user = UserObject(
                            firstName:
                                linkedInUser.user.firstName!.localized!.label!,
                            lastName:
                                linkedInUser.user.lastName!.localized!.label!,
                            email: linkedInUser.user.email!.elements![0]
                                .handleDeep!.emailAddress!,
                            profileImageUrl: linkedInUser
                                .user
                                .profilePicture!
                                .displayImageContent!
                                .elements![0]
                                .identifiers![0]
                                .identifier!,
                          );
                          Navigator.pop(context);
                          Get.to(() => ProfleUI(
                                user: user,
                              ));
                        },
                      ),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
            ]),
      ),
    );
  }
}
