import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/common/widgets/custom_button.dart';
import 'package:biz_alert/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../constants/style.dart';
import '../../../../providers/theme_notifier_provider.dart';

class AddPortfolioScreen extends StatefulWidget {
  static const String routeName = '/add-portfolio';
  const AddPortfolioScreen({Key? key}) : super(key: key);

  @override
  State<AddPortfolioScreen> createState() => _AddPortfolioScreenState();
}

class _AddPortfolioScreenState extends State<AddPortfolioScreen> {
  final nameKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.pop(context);
          },
          text: "Biz Portfolio",
          // Add Icon
          icon2: Icons.add,
          onPressed2: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          15.h,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 25.h),
          height: 280.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: Provider.of<ThemeNotifier>(context).getTheme() == darkTheme
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Form(
              key: nameKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    "Portfolio Name",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Provider.of<ThemeNotifier>(context).getTheme() ==
                              darkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Portofolio Name
                  CustomTextField(
                    controller: nameController,
                    hintText: "",
                    width: 280.w,
                  ),

                  SizedBox(
                    height: 30.h,
                  ),

                  // Buttons
                  Row(
                    children: [
                      // Save Button
                      CustomButton(
                        onPressed: () {},
                        text: "Save",
                        borderColor: Colors.greenAccent.shade700,
                        textSize: 20.sp,
                        bgColor: Colors.blue[300],
                        textColor: Colors.white,
                        width: 100.w,
                        height: 50.h,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      // Cancel Button
                      CustomButton(
                        onPressed: () {},
                        text: "Cancel",
                        borderColor: Colors.grey,
                        textSize: 20.sp,
                        bgColor: Colors.grey[350],
                        textColor: Colors.black,
                        width: 100.w,
                        height: 50.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
