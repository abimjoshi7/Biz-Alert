import 'package:biz_alert/bloc/authentication_bloc.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  int socialStatus = 2;
  bool isSigningIn = false;

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthenticationBloc>(context).add(GoogleSignInRequested());
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
                    _authenticateWithGoogle(context);
                  },
                  // onTap: () async {
                  //   setState(() {
                  //     _isSigningIn = true;
                  //   });

                  //   GoogleSignInAccount? googleSignInAccount =
                  //       await FirebaseAuthentication.signInWithGoogle(
                  //           context: context);

                  //   setState(() {
                  //     _isSigningIn = false;
                  //   });

                  //   final GoogleSignInAuthentication googleSignInAuthentication =
                  //       await googleSignInAccount!.authentication;

                  //   final AuthCredential credential = GoogleAuthProvider.credential(
                  //     accessToken: googleSignInAuthentication.accessToken,
                  //     idToken: googleSignInAuthentication.idToken,
                  //   );

                  //   UserCredential userCredential = await FirebaseAuth.instance
                  //       .signInWithCredential(credential);

                  //   User? user = userCredential.user;

                  //   if (googleSignInAccount != null) {
                  //     if (userCredential.additionalUserInfo!.isNewUser == null) {
                  //       var res = await DioSocialSingUp()
                  //           .registerNewSocialUser(
                  //         firstName: user!.displayName,
                  //         lastName: '',
                  //         // password: 'Merolagani',
                  //         password: 'Podamibe',
                  //         mobileNumber: '',
                  //         socialStatus: socialStatus,
                  //         sexType: '',
                  //         email: user.email,
                  //       )
                  //           .then(
                  //         (value) async {
                  //           var log = await DioLogoutProfile().viewLoginUserNew1(
                  //               user.email, 'merolaganiapp', socialStatus);
                  //           const CircularProgressIndicator(); //added new trying
                  //           if (log!.dataCollection.msgType.toUpperCase() ==
                  //               "SUCCESS".toUpperCase()) {
                  //             SecureStorage().writeData(
                  //                 key: saveNumber,
                  //                 value: log.dataCollection.data[0].mobileNumber);
                  //             SecureStorage().writeData(
                  //                 key: saveUserID,
                  //                 value: log.dataCollection.data[0].userId);
                  //             SecureStorage().writeData(
                  //                 key: saveToken,
                  //                 value: log.dataCollection.data[0].sessionToken);

                  //             if (!mounted) return;
                  //             Navigator.popAndPushNamed(
                  //                 context, DashboardScreen.routeName);
                  //           }
                  //         },
                  //       );
                  //     } else {
                  //       var res = await DioLogoutProfile().viewLoginUserNew1(
                  //           user!.email, 'merolaganiapp', socialStatus);
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
                          height: 45.h,
                          child: SvgPicture.asset(
                            'assets/images/google.svg',
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
