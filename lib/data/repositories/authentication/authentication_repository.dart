import 'package:auto_access/features/authentication/screens/signup/widgets/verify_email.dart';
import 'package:auto_access/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';
import '../../../utility/exception/firebase_auth_exceptions.dart';
import '../../../utility/exception/firebase_exceptions.dart';
import '../../../utility/exception/format_exceptions.dart';
import '../../../utility/exception/platform_exceptions.dart';
import '../personalization/user_repository.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  ///variables
   final deviceStorage = GetStorage();
   final _auth = FirebaseAuth.instance;
  late final Rx<User?> _authUser;

   ///Get Authenticated user data
  User? get authUser => _auth.currentUser;
  String get getUserID => _authUser.value?.uid ?? "";



   ///called from main dart on app launch
 @override
  void onReady(){
   //Removing the native screen
   FlutterNativeSplash.remove();
   //Redirect to the appropriate screen
   screenRedirect();
 }

 ///Function to show relevant screen
 void screenRedirect() async {
   final user = _auth.currentUser;

   if(user != null){
     //if the user is logged in
     if(user.emailVerified){
       //if the user is verified go to the main navigation menu
       Get.offAll(() => const NavigationMenu());
     } else {
       //if the user is not verified go to the verify email screen
       Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
     }
   }else{
//Local Storage
     deviceStorage.writeIfNull('IsFirstTime', true);

     //checking if its the first time to use the app
     deviceStorage.read('IsFirstTime') != true
         ? Get.offAll(() => const LoginScreen())  //Redirect to login screen if not the first time
         : Get.offAll(const OnBoardingScreen()); //Redirect to OnBoardingScreen if its the first time
   }
 }

  ///Email Authentication - sign in/Login in
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
   try {
     return await _auth.signInWithEmailAndPassword(email: email, password: password);
   }on FirebaseAuthException catch (e) {
     throw RFirebaseAuthException(e.code).message;
   }  on FirebaseException catch (e) {
     throw RFirebaseException(e.code).message;
   } on FormatException catch (_) {
     throw const RFormatException();
   } on PlatformException catch (e) {
     throw RPlatformException(e.code).message;
   } catch (e) {
     throw 'Something went wrong, Please try again';
   }
  }
 ///Email Authentication - register
 Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
   try {
     return await _auth.createUserWithEmailAndPassword(email: email, password: password);
   } on FirebaseAuthException catch (e) {
     throw RFirebaseAuthException(e.code).message;
   }  on FirebaseException catch (e) {
     throw RFirebaseException(e.code).message;
   } on FormatException catch (_) {
     throw const RFormatException();
   } on PlatformException catch (e) {
     throw RPlatformException(e.code).message;
   } catch (e) {
     throw 'Something went wrong, Please try again';
   }
 }

   ///Email verification
 Future<void> sendEmailVerification() async {
   try {
     await _auth.currentUser?.sendEmailVerification();
   } on FirebaseAuthException catch (e) {
     throw RFirebaseAuthException(e.code).message;
   }  on FirebaseException catch (e) {
     throw RFirebaseException(e.code).message;
   } on FormatException catch (_) {
     throw const RFormatException();
   } on PlatformException catch (e) {
     throw RPlatformException(e.code).message;
   } catch (e) {
     throw 'Something went wrong, Please try again';
   }
 }

 ///Forget password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
       await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    }  on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
 ///ReAuthenticate user
Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
   try {
     //Creating a credential
  AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

  //ReAuthenticate
     await _auth.currentUser!.reauthenticateWithCredential(credential);
   }on FirebaseAuthException catch (e) {
     throw RFirebaseAuthException(e.code).message;
   }  on FirebaseException catch (e) {
     throw RFirebaseException(e.code).message;
   } on FormatException catch (_) {
     throw const RFormatException();
   } on PlatformException catch (e) {
     throw RPlatformException(e.code).message;
   } catch (e) {
     throw 'Something went wrong, Please try again';
   }
}
 ///Google Authentication
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //Trigger the authentication flow - popup with list of emails
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //Obtaining the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      //Creating a new credential
      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //Once signed in returning the user credentials
      //return await _auth.signInWithCredential(credentials);
      return await FirebaseAuth.instance.signInWithCredential(credentials);

    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    }  on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong.');
      return null;
    }
 }
 ///facebook authentication
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email']);

      // Create a credential from the access token
      final AccessToken? accessToken = loginResult.accessToken;
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken as String);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      throw RFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw RFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const RFormatException();
    } on PlatformException catch (e) {
      throw RPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

 ///logout user
Future<void> logout() async {
   try {
     await GoogleSignIn().signOut();
     await FirebaseAuth.instance.signOut();
     Get.offAll(() => const LoginScreen());
   }on FirebaseAuthException catch (e) {
     throw RFirebaseAuthException(e.code).message;
   }  on FirebaseException catch (e) {
     throw RFirebaseException(e.code).message;
   } on FormatException catch (_) {
     throw const RFormatException();
   } on PlatformException catch (e) {
     throw RPlatformException(e.code).message;
   } catch (e) {
     throw 'Something went wrong, Please try again';
   }
}
 ///Delete user - Removing user Auth and Firestore Acc
Future<void> deleteAccount() async {
   try {
     await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
     await _auth.currentUser?.delete();
   }on FirebaseAuthException catch (e) {
     throw RFirebaseAuthException(e.code).message;
   }  on FirebaseException catch (e) {
     throw RFirebaseException(e.code).message;
   } on FormatException catch (_) {
     throw const RFormatException();
   } on PlatformException catch (e) {
     throw RPlatformException(e.code).message;
   } catch (e) {
     throw 'Something went wrong, Please try again';
   }
}
}


