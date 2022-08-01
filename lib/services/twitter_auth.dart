// ignore_for_file: empty_constructor_bodies

import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_login/twitter_login.dart';

Future<TwitterId> signInWithTwitter() async {
  // Create a TwitterLogin instance
  final twitterLogin = TwitterLogin(
      apiKey: 'q90jpdDRHLp0vJm7m8EVjXumk',
      apiSecretKey: 'QKbDh1cGMlKjjiQyXJqYe8jFPeuONs8LVwRmgIndPwVv2atI3J',
      redirectURI: 'flutter-twitter-login://');

  // Trigger the sign-in flow
  final authResult = await twitterLogin.login();
  String Access_Token = '1534574697353949185-5E3BCRUwWPEWDYp1dge8fdzAEBBpYd';
  String Access_Token_Secret = 'Z2ywOGwX14jROw0oC8w1cjU3YmEYn0l9dQ5A5HcMfuIcj';

  final twitterAuthCredential = TwitterAuthProvider.credential(
    accessToken: authResult.authToken!,
    secret: authResult.authTokenSecret!,
  );

  await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);

  TwitterId userid = TwitterId(
      email: 'user name is ${authResult.user!.screenName}',
      name: authResult.user!.name,
      photourl: authResult.user!.thumbnailImage,
      userUid: authResult.user!.id.toString());
  return userid;
}

class TwitterId {
  String? name;
  String? userUid;
  String? email;
  String? photourl;
  TwitterId({this.email, this.userUid, this.name, this.photourl});
}
