import 'package:firebase_auth/firebase_auth.dart';

class ConfigFirebaseAuth {
  FirebaseAuth auth = FirebaseAuth.instance;

  static String _verificationId = "";
  static int? _resendToken = 1;

  int timeOutSeconds = 120;

  static ConfigFirebaseAuth get intent => ConfigFirebaseAuth();

  verifyPhoneNumber(String phone, Function(FirebaseAuthResult) callBack) async {
    print(phone);
    if (phone.startsWith('0')) phone = phone.substring(1);
    await auth.verifyPhoneNumber(
        phoneNumber: '+84' + phone,
        timeout: Duration(seconds: timeOutSeconds),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          // final authResult =
          //     await _auth.signInWithCredential(phoneAuthCredential);
          print("verificationCompleted-----${phoneAuthCredential.smsCode}");
        },
        verificationFailed: (FirebaseAuthException authException) {
          print("verificationFailed---- ${authException.message}");
          print("verificationFailed---- ${authException.code}");
          if (authException.code == 'quotaExceeded') {
            callBack.call(FirebaseAuthResult(
                status: AuthStatus.QuotaExceeded, msg: authException.message));
          } else {
            callBack.call(FirebaseAuthResult(
                status: AuthStatus.Fail, msg: authException.message));
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          _verificationId = verificationId;
          _resendToken = resendToken;
          callBack.call(FirebaseAuthResult(status: AuthStatus.CodeSent));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("codeAutoRetrievalTimeout-----");
        },
        forceResendingToken: _resendToken ?? 1);
  }

  validateCode(String code, Function(FirebaseAuthResult) callBack) async {
    print(code);
    print("_verificationId----$_verificationId");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: code);
    UserCredential? authRes =
        await auth.signInWithCredential(credential).catchError((e) {
      print("validateCode----${e.toString()}");
      callBack
          .call(FirebaseAuthResult(status: AuthStatus.Fail, msg: e.toString()));
    });
    if (authRes == null) {
      callBack.call(FirebaseAuthResult(
          status: AuthStatus.Fail, msg: 'Không thể đăng nhập. Mã lỗi: 0001'));
    } else {
      final String token = await authRes.user?.getIdToken() ?? "";
      print('ConfigFirebaseAuth-----Token: $token');
      callBack.call(FirebaseAuthResult(
          status: AuthStatus.Verified, token: token, user: authRes.user));
    }
  }

  verifyEmailVsPassword(String email, String password,
      Function(FirebaseAuthResult) callBack) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final String token = await userCredential.user?.getIdToken() ?? "";
      callBack.call(FirebaseAuthResult(
          status: AuthStatus.Verified,
          token: token,
          user: userCredential.user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        callBack.call(FirebaseAuthResult(
            status: AuthStatus.Fail, msg: 'Không tìn thấy email này'));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        callBack.call(FirebaseAuthResult(
            status: AuthStatus.Fail, msg: 'Mật khẩu không chính xác'));
        print('Wrong password provided for that user.');
      }
    }
  }

  changePassword(String email, String password, String newPassword,
      Function(FirebaseAuthResult) callBack) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final String token = await userCredential.user?.getIdToken() ?? "";
      userCredential.user?.updatePassword(newPassword).then((value) {
        print("Successfully changed password");
        callBack.call(FirebaseAuthResult(
            status: AuthStatus.Verified,
            token: token,
            user: userCredential.user));
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        callBack.call(FirebaseAuthResult(
            status: AuthStatus.Fail, msg: 'Không tìn thấy email này'));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        callBack.call(FirebaseAuthResult(
            status: AuthStatus.Fail, msg: 'Mật khẩu không chính xác'));
        print('Wrong password provided for that user.');
      }
    }
  }
}

enum AuthStatus { Verified, Timeout, CodeSent, Fail, QuotaExceeded }

class FirebaseAuthResult {
  AuthStatus? status;
  String? token;
  String? msg;
  User? user;

  FirebaseAuthResult({this.status, this.token, this.msg, this.user});
}
