import 'package:biz_alert/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:biz_alert/constants/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//light themedata
final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: GlobalVariablesColor.backgroundColor,
    appBarTheme: const AppBarTheme(
      elevation: 1,
      iconTheme: IconThemeData(
        color: GlobalVariablesColor.mainColor,
      ),
      color: Colors.white,
      actionsIconTheme: IconThemeData(color: GlobalVariablesColor.mainColor),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return GlobalVariablesColor.mainColor;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return GlobalVariablesColor.mainColor;
        }
        return null;
      }),
    ),
    inputDecorationTheme: InputDecorationTheme(
      // isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(11.0, 0.0, 11.0, 0.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius2),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.solid,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: GlobalVariablesColor.mainColor)),
      fillColor: GlobalVariablesColor.backgroundColor,
      filled: true,
      // labelText: "Email",
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15.sp,
        color: Colors.black,
      ),
    ));

//dark themedata
final darkTheme = ThemeData.dark().copyWith(
  appBarTheme: const AppBarTheme(
    elevation: 1,
    iconTheme: IconThemeData(
      color: GlobalVariablesColor.mainColor,
    ),
    // color: Colors.white,
    actionsIconTheme: IconThemeData(color: GlobalVariablesColor.mainColor),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return GlobalVariablesColor.mainColor;
      }
      return null;
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return GlobalVariablesColor.mainColor;
      }
      return null;
    }),
  ),
);

//Date Time and Month Style
TextStyle dateTimeStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 10.sp,
  color: GlobalVariablesColor.mainColor,
);

// Table Style
TextStyle tableStyle = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.bold,
);

TextStyle dashboardTableStyle = TextStyle(
  fontSize: 15.sp,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// Table Style Row
TextStyle tableRowStyle = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

TextStyle dashboardTableRowStyle = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

// Stock Alert Style
TextStyle stockAlertSyle = TextStyle(
  fontSize: 15.sp,
  fontWeight: FontWeight.w400,
  color: GlobalVariablesColor.mainColor,
);

// AppBar Title
TextStyle appbarTitleStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: GlobalVariablesColor.mainColor);

// Services
TextStyle serviceTitleStyle = TextStyle(
  fontSize: 18.sp, fontWeight: FontWeight.bold,
  //  color: Colors.black
);

// Market Summary Style
TextStyle marketSummaryStyle = TextStyle(
  fontSize: 11.sp,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);

// TextFormFieldStyle
TextStyle styleTextFormField = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 15.sp,
  color: Colors.black,
);

// DropDownStyle
TextStyle dropDownStyle = TextStyle(
  // fontWeight: FontWeight.w500,
  fontSize: 8.sp,
  color: Colors.black,
);

// Portfolio Data Style
TextStyle portfolioWhiteStyle = TextStyle(
  fontSize: 15.sp,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

TextStyle portfolioGreyStyle = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w500,
  color: Colors.grey[700],
);

TextStyle portfolioblackStyle = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w500,
  color: Colors.black.withOpacity(0.7),
);

// Profile Page Style
TextStyle profileStyle = TextStyle(
  fontSize: 15.sp,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

// Company Detail Style
TextStyle companyDetailStyle = TextStyle(
  fontSize: 11.sp,
  fontWeight: FontWeight.bold,
);

// Company Detail Style1
TextStyle companyDetailStyle1 = TextStyle(
  fontSize: 11.sp,
  fontWeight: FontWeight.w500,
);

//Button
ButtonStyle styleMainButton = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.grey[700]),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.radius10),
    ),
  ),
  elevation: MaterialStateProperty.all(0.0),
);

// Text InputDecoration
InputDecoration textInputDecoration = InputDecoration(
  // isDense: true,
  contentPadding: const EdgeInsets.fromLTRB(11.0, 0.0, 11.0, 0.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius2),
    borderSide: const BorderSide(
      width: 0,
      style: BorderStyle.solid,
    ),
  ),
  focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: GlobalVariablesColor.mainColor)),
  fillColor: GlobalVariablesColor.backgroundColor,
  filled: true,
  labelText: "Email",
  labelStyle: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 15.sp,
    color: Colors.black,
  ),
);
