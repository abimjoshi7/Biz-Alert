import 'package:biz_alert/common/widgets/custom_app_bar1.dart';
import 'package:biz_alert/constants/global_variables.dart';
import 'package:biz_alert/features/payment/widget/packages_box.dart';
import 'package:flutter/material.dart';

class PortfolioPayment extends StatefulWidget {
  static const String routeName = '/portfolio-payment';
  const PortfolioPayment({Key? key}) : super(key: key);

  @override
  State<PortfolioPayment> createState() => _PortofolioPaymentState();
}

class _PortofolioPaymentState extends State<PortfolioPayment> {
  List packageList = [
    "6 Months",
    "Biz Alert Portfolio 1 day Upfront pack",
    "180 days Portfolio Daily Installment",
    "360 days Portfolio Daily Installment",
    "180 days Portfolio 3 day Installment",
    "360 days Portfolio 3 day Installment",
    "Biz Alert Portfolio 3 day Upfront pack",
    "1 Year"
  ];
  List amountList = [
    "Rs. 500.0",
    "Rs. 4.0",
    "Rs. 3.8",
    "Rs. 2.9",
    "Rs. 13.6",
    "Rs. 12.6",
    "Rs. 14.0",
    "Rs. 1000"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariablesColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar1(
          onPressed: () {
            Navigator.pop(context);
          },
          text: "Portfolio Payment",
          // Search Icon
        ),
      ),
      body: ListView.builder(
          itemCount: packageList.length,
          itemBuilder: (context, index) {
            return PackagesBox(
              onTap: () {},
              packageText: packageList[index],
              amountText: amountList[index],
            );
          }),
    );
  }
}
