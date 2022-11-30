import 'package:biz_alert/bloc/authentication_bloc.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacebookSignInButton extends StatefulWidget {
  const FacebookSignInButton({Key? key}) : super(key: key);

  @override
  State<FacebookSignInButton> createState() => _FacebookSignInButtonState();
}

class _FacebookSignInButtonState extends State<FacebookSignInButton> {
  int socialStatus = 1;
  bool isSigningIn = false;

  void _authenticateWithFacebook(context) {
    BlocProvider.of<AuthenticationBloc>(context).add(FacebookSignInRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: isSigningIn
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  GlobalVariablesColor.mainColor1),
            )
          : BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationSuccess) {
                  Navigator.pushNamed(context, DashboardScreen.routeName);
                }
                if (state is AuthenticationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    _authenticateWithFacebook(context);
                  },
                  // onTap: () async {
                  //   setState(() {
                  //     _isSigningIn = true;
                  //   });

                  //   final LoginResult loginResult =
                  //       await FacebookAuth.instance.login();

                  //   setState(() {
                  //     _isSigningIn = false;
                  //   });

                  //   final OAuthCredential facebookAuthCredential =
                  //       FacebookAuthProvider.credential(
                  //           loginResult.accessToken!.token);
                  //   UserCredential? user = await FirebaseAuth.instance
                  //       .signInWithCredential(facebookAuthCredential);

                  //   if (loginResult != null) {
                  //     if (user.additionalUserInfo!.isNewUser == null) {
                  //       DioSocialSignUp()
                  //           .registerNewSocialUser(
                  //         firstName: user.user!.displayName,
                  //         lastName: '',
                  //         password: 'Merolagani',
                  //         mobileNumber: '',
                  //         socialStatus: socialStatus,
                  //         sexType: '',
                  //         email: user.user!.email,
                  //       )
                  //           .then(
                  //         (value) async {
                  //           var log = await DioLogoutProfile().viewLoginUserNew1(
                  //               user.user!.email, 'merolaganiapp', socialStatus);
                  //           if (log is LoginUserNew1Model) {
                  //             SecureStorage().writeData(
                  //                 key: saveNumber,
                  //                 value: log.dataCollection.data[0].mobileNumber);
                  //             SecureStorage().writeData(
                  //                 key: saveUserID,
                  //                 value: log.dataCollection.data[0].userId);
                  //             SecureStorage().writeData(
                  //                 key: saveToken,
                  //                 value: log.dataCollection.data[0].sessionToken);
                  //           }
                  //           if (!mounted) return;
                  //           Navigator.popAndPushNamed(
                  //               context, DashboardScreen.routeName);
                  //         },
                  //       );
                  //     } else {
                  //       var res = await DioLogoutProfile().viewLoginUserNew1(
                  //           user.user!.email, 'merolaganiapp', socialStatus);

                  //       if (res is LoginUserNew1Model) {
                  //         SecureStorage().writeData(
                  //             key: saveNumber,
                  //             value: res.dataCollection.data[0].mobileNumber);
                  //         SecureStorage().writeData(
                  //             key: saveUserID,
                  //             value: res.dataCollection.data[0].userId);
                  //         SecureStorage().writeData(
                  //             key: saveToken,
                  //             value: res.dataCollection.data[0].sessionToken);
                  //       }
                  //       if (!mounted) return;

                  //       Navigator.popAndPushNamed(
                  //           context, DashboardScreen.routeName);
                  //     }
                  //   } else {
                  //     if (!mounted) return;
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //         content: Text("Server Error."),
                  //       ),
                  //     );
                  //   }
                  // },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 120.w,
                          height: 70.h,
                          child: Image.asset(
                            'assets/images/facebook.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
