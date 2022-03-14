// // ignore_for_file: non_constant_identifier_names

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_application_1/services/auth_service.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';

// class AuthBloc {
//   final authService = AuthService();
//   final fb = FacebookLogin();

//   Future<Stream> get currentUser async => authService.currentUser;

//   loginFacebook() async {
//     print('Starting Facebook Login');

//     final res = await fb.logIn(permissions: [
//       FacebookPermission.publicProfile,
//       FacebookPermission.email
//     ]);

//     switch (res.status) {
//       case FacebookLoginStatus.success:
//         print('It Worked');

//         final FacebookAccessToken? fbToken = res.accessToken;
//         final AuthCredential credential =
//             FacebookAuthProvider.getCredential(accessToken: fbToken?.token);

//         final result = await authService.signInWithCredentail(credential);
// print('${result.user.displayName}is now logged in'); 

//         break;
//       case FacebookLoginStatus.cancel:
//         print('The user canceld the login');
//         break;
//       case FacebookLoginStatus.error:
//         print('There was an error');
//         break;
//     }
//   }
// }
