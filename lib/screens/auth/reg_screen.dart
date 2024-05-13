import 'package:dream_craft/theme/theme.dart';
import 'package:dream_craft/widgets/background_gradient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/locale_keys.g.dart';
import '../../main.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/gradient_text.dart';
import 'login_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();

  bool isPasswordObscured = true;
  bool isPasswordConfirmObscured = true;

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
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
                    controller: _firstNameController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: LocaleKeys.hint_enter_first_name.tr(),
                    ),
                  ),

                  const SizedBox(height: 16,),

                  Row(
                    children: [
                      Text(LocaleKeys.last_name.tr()),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _lastNameController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: LocaleKeys.hint_enter_last_name.tr(),
                    ),
                  ),

                  const SizedBox(height: 16,),

                  Row(
                    children: [
                      Text(LocaleKeys.nickname.tr()),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _nicknameController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: LocaleKeys.hint_enter_nickname.tr(),
                    ),
                  ),

                  const SizedBox(height: 16,),

                  Row(
                    children: [
                      Text(LocaleKeys.email.tr()),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: LocaleKeys.hint_enter_email.tr(),
                    ),
                  ),

                  const SizedBox(height: 16,),

                  Row(
                    children: [
                      Text(LocaleKeys.password.tr()),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
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

                  const SizedBox(height: 16,),

                  Row(
                    children: [
                      Text(LocaleKeys.confirm_password.tr()),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _passwordConfirmController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    obscureText: isPasswordConfirmObscured,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.hint_enter_password.tr(),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordConfirmObscured = !isPasswordConfirmObscured;
                          });
                        },
                        child: isPasswordConfirmObscured
                            ? const Icon(
                          Icons.panorama_fish_eye,
                        )
                            : const Icon(
                          Icons.remove_red_eye,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16,),

                  Row(
                    children: [
                      Text(LocaleKeys.avatar.tr()),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _avatarController,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: LocaleKeys.hint_enter_link.tr(),
                    ),
                  ),

                  const SizedBox(height: 32,),

                  FilledButton(
                    onPressed: submit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(
                          LocaleKeys.sign_up.tr(),
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
                      Text(LocaleKeys.have_account.tr()),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const LoginScreen()),
                          ),
                        ),
                        child: Text(
                          LocaleKeys.log_in.tr(),
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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Future submit() async {
    await Provider.of<Auth>(context, listen: false).register(
      credential: {
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'nickname': _nicknameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password_confirmation': _passwordConfirmController.text,
      },
      // locale: context.locale.countryCode,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: ((context) => const HomePage()),
      ),
    );
  }

}
