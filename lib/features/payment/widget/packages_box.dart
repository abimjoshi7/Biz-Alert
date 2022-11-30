import 'package:biz_alert/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackagesBox extends StatelessWidget {
  final String packageText;
  final String amountText;
  final VoidCallback onTap;
  const PackagesBox(
      {Key? key,
      required this.packageText,
      required this.amountText,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   children: [
    //     // Join Us container
    //     GestureDetector(
    //       onTap: onTap,
    //       child: Container(
    //         margin:
    //             const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
    //         padding: const EdgeInsets.only(bottom: 10),
    //         height: 150,
    //         width: MediaQuery.of(context).size.width / 1,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           color: GlobalVariablesColor.mainColor,
    //         ),
    //         child: Align(
    //             alignment: Alignment.bottomCenter,
    //             child: Text(
    //               "Join Us",
    //               style: TextStyle(
    //                 fontSize: 20.sp,
    //                 fontWeight: FontWeight.w500,
    //                 color: Colors.white,
    //               ),
    //             )),
    //       ),
    //     ),
    //     //Package and Amount Container
    //     Container(
    //       margin: const EdgeInsets.all(10),
    //       padding: const EdgeInsets.all(10),
    //       height: 110,
    //       width: MediaQuery.of(context).size.width,
    //       decoration: BoxDecoration(
    //         // color: Colors.amber,
    //         borderRadius: BorderRadius.circular(10),
    //         boxShadow: const [
    //           BoxShadow(
    //             color: GlobalVariablesColor.mainColor,
    //           ),
    //           BoxShadow(
    //             color: Colors.white,
    //             spreadRadius: -1.0,
    //             blurRadius: 1.0,
    //           ),
    //         ],
    //       ),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: MediaQuery.of(context).size.width / 2,
    //             child: Column(children: [
    //               Center(
    //                 child: Text(
    //                   "Package",
    //                   style: TextStyle(
    //                       fontSize: 20.sp, fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Text(
    //                 packageText,
    //                 style:
    //                     TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
    //               ),
    //             ]),
    //           ),
    //           const SizedBox(
    //             width: 5,
    //           ),
    //           Container(
    //             height: 120,
    //             color: GlobalVariablesColor.mainColor,
    //             width: 2,
    //           ),
    //           const SizedBox(
    //             width: 5,
    //           ),
    //           SizedBox(
    //             width: MediaQuery.of(context).size.width / 3,
    //             child: Column(children: [
    //               Text(
    //                 "Amount",
    //                 style:
    //                     TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Text(
    //                 amountText,
    //                 style:
    //                     TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
    //               ),
    //             ]),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );

    return Stack(
      children: [
        // Join Us container
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin:
                const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
            padding: const EdgeInsets.only(right: 5),
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: GlobalVariablesColor.mainColor,
            ),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Join Us",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
        //Package and Amount Container
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 120,
          width: MediaQuery.of(context).size.width / 1.25,
          decoration: BoxDecoration(
            // color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: GlobalVariablesColor.mainColor,
              ),
              BoxShadow(
                color: Colors.white,
                spreadRadius: -2.0,
                blurRadius: 2.0,
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(children: [
                  Text(
                    "Package",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    packageText,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                  ),
                ]),
              ),
              // Line
              Container(
                height: 120,
                color: GlobalVariablesColor.mainColor,
                width: 2,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Column(children: [
                  Text(
                    "Amount",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    amountText,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
