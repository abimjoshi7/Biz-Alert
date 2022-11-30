import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback callback;
  final String? errorMessage;
  final bool isShowingButton;

  const ErrorScreen(
      {Key? key,
      this.errorMessage,
      required this.callback,
      this.isShowingButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Icon(
                    Icons.tv_off_outlined,
                    size: 50,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: Text(errorMessage!,
                          style: const TextStyle(color: Colors.black87),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Visibility(
                    visible: isShowingButton,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent),
                      onPressed: callback,
                      child: const Text(
                        "RETRY",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
