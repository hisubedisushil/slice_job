import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

// import 'package:pinput/pinput.dart';
// import 'package:provider/provider.dart';

import '/packages/panara_dialogs/panara_dialogs.dart';
import '../../../constants/app_colors.dart';

class VerifyView extends StatefulWidget {
  final String name;
  final String email;
  final String phone;

  const VerifyView({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  final _otp = TextEditingController();

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Verify your email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Hi ${widget.name}! Check your email and enter '
                      'verification code below to verify your email '
                      'address and complete registration process.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // Pinput(
                  //   controller: _otp,
                  //   length: 6,
                  //   defaultPinTheme: PinTheme(
                  //     width: (width - 20) / 8,
                  //     height: (width - 20) / 6,
                  //     textStyle: TextStyle(
                  //       fontSize: 32.0,
                  //       color: AppColors.black,
                  //       fontWeight: FontWeight.bold,
                  //       height: 0.75,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: AppColors.primary),
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 40.0),
                  Row(
                    children: [
                      Container(
                        height: 56.0,
                        width: 56.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors.red,
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Ionicons.arrow_back,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: MaterialButton(
                          onPressed: _verify,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: AppColors.primary,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          minWidth: double.infinity,
                          height: 56.0,
                          elevation: 0.0,
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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

  _verify() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_otp.text.length != 6) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Invalid OTP",
        message: "OTP must be 6 digit.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }

    // final result = await showDialog(
    //   context: context,
    //   builder: (context) => FutureProgressDialog(
    //     context.read<AuthenticationController>().verify(
    //           email: widget.email,
    //           phone: widget.phone,
    //           pin: _otp.text,
    //         ),
    //   ),
    // );
    // log(result.toString());

    // if (result is bool) {
    //   if (result) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (_) => const LoginView(),
    //       ),
    //     );
    //   } else {
    //     await PanaraInfoDialog.showAnimatedGrow(
    //       context,
    //       title: "Verification Failed",
    //       message: "Oops! Something went wrong.",
    //       buttonText: 'Okay',
    //       onTapDismiss: () => Navigator.pop(context),
    //       panaraDialogType: PanaraDialogType.error,
    //       barrierDismissible: true,
    //     );
    //   }
    // } else if (result is String) {
    //   await PanaraInfoDialog.showAnimatedGrow(
    //     context,
    //     title: "Verification Failed",
    //     message: result,
    //     buttonText: 'Okay',
    //     onTapDismiss: () => Navigator.pop(context),
    //     panaraDialogType: PanaraDialogType.error,
    //     barrierDismissible: true,
    //   );
    //   return;
    // } else {
    //   await PanaraInfoDialog.showAnimatedGrow(
    //     context,
    //     title: "Verification Failed",
    //     message: "Oops! Something went wrong.",
    //     buttonText: 'Okay',
    //     onTapDismiss: () => Navigator.pop(context),
    //     panaraDialogType: PanaraDialogType.error,
    //     barrierDismissible: true,
    //   );
    //   return;
    // }
  }
}
