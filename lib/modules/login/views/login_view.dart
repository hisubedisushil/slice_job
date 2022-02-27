import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../../constants/app_colors.dart';
import '../../register/views/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
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
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text(
                        'Email Address',
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: AppColors.white.withOpacity(0.8),
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      label: const Text(
                        'Password',
                      ),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: AppColors.white.withOpacity(0.8),
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _showPassword = !_showPassword;
                          setState(() {});
                        },
                        icon: Icon(
                          _showPassword
                              ? Ionicons.eye_off_outline
                              : Ionicons.eye_outline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: double.infinity,
                    height: 56.0,
                    elevation: 0.0,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Text(
                            'Forget Password?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterView(),
                            ),
                          );
                        },
                        child: Text(
                          'Create New Account',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SocialLoginButton(
                    buttonType: SocialLoginButtonType.facebook,
                    borderRadius: 10.0,
                    height: 56.0,
                    text: 'Login Using Facebook',
                    onPressed: () {},
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
