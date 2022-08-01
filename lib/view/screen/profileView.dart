// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shadinlab_one/Controller/auth_controller.dart';
import 'package:shadinlab_one/model/usermodel.dart';

class ProfleUI extends StatelessWidget {
  UserObject? user;
  ProfleUI({Key? key, this.user}) : super(key: key);
  AuthController controller = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                height: 200,
                width: 200,
                fit: BoxFit.cover,
                imageUrl: user!.profileImageUrl,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'First: ${user!.firstName} ',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Last: ${user!.lastName} ',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email: ${user!.email}',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  controller.logoutUser.value = true;
                  Get.back();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 143, 223, 184)),
                ),
                child: const Text('log-out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
