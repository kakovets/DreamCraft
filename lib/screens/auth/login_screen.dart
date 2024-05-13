import 'package:dream_craft/screens/auth/reg_screen.dart';
import 'package:dream_craft/widgets/background_gradient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/locale_keys.g.dart';
import '../../main.dart';
import '../../providers/auth_provider.dart';
import '../../theme/theme.dart';
import '../../widgets/gradient_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    LocaleKeys.welcome.tr(),
                    style: TextStyle(
                      color: Theme.of(context).extension<MyColors>()!.accentCyan,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Text(LocaleKeys.first_name.tr()),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _loginController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: LocaleKeys.hint_email_or_nickname.tr(),
                    ),
                  ),

                  const SizedBox(height: 16,),

                  Row(
                    children: [
                      Text(LocaleKeys.password.tr(),),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    obscureText: isPasswordObscured,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.hint_enter_password.tr(),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordObscured = !isPasswordObscured;
                          });
                        },
                        child: isPasswordObscured
                            ? const Icon(
                          Icons.panorama_fish_eye,
                        )
                            : const Icon(
                          Icons.remove_red_eye,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  FilledButton(
                    onPressed: submit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(
                          LocaleKeys.log_in.tr(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Theme.of(context).extension<MyColors>()!
                                  .buttonGradientFirst,
                              Theme.of(context).extension<MyColors>()!
                                  .buttonGradientSecond,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(
                    thickness: 2,
                    height: 64,
                    color: Colors.white,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.dont_have_account.tr(),),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const Register()),
                          ),
                        ),
                        child: Text(
                          LocaleKeys.sign_up.tr(),
                          style: TextStyle(
                            color: Theme.of(context).extension<MyColors>()!.accentCyan,
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

  Future submit() async {
    await Provider.of<Auth>(context, listen: false).login(
      credential: {
        'login': _loginController.text,
        'password': _passwordController.text,
      },
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const HomePage()),
      ),
    );
  }

}
