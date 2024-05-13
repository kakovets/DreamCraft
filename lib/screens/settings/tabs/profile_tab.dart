import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_craft/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../models/user.dart';
import '../../../providers/auth_provider.dart';
import '../../../theme/theme.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();

  bool isPasswordObscured = true;
  bool isPasswordConfirmObscured = true;

  late User user;

  @override
  void initState() {
    super.initState();

    user = Provider.of<Auth>(context, listen: false).user!;

    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _nicknameController.text = user.nickname;
    _emailController.text = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authProvider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [

                ClipOval(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    height: MediaQuery.of(context).size.width * .4,
                    child: CachedNetworkImage(
                      imageUrl: authProvider.user!.avatar,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Icon(
                        Icons.cloud,
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),

                const SizedBox(height: 16,),

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

                const SizedBox(height: 16,),

                FilledButton(
                  onPressed: () {
                    authProvider.changeMe(
                      {
                        'first_name': _firstNameController.text,
                        'last_name': _lastNameController.text,
                        'nickname': _nicknameController.text,
                        'avatar': _avatarController.text,
                        'email': _emailController.text,
                        'password': _passwordController.text,
                        'password_confirmation': _passwordConfirmController.text,
                      },
                    );
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color(0xFF69BBED),
                    ),
                  ),
                  child: Text(LocaleKeys.save.tr()),
                ),

                const SizedBox(height: 32,),

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        color: Theme.of(context).extension<MyColors>()!
                            .transparentWhite,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.language),
                          const SizedBox(width: 16,),
                          Text(LocaleKeys.language.tr()),
                        ],
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: Utils.languages.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      Utils.languages[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    context.setLocale(
                                      Locale(Utils.langCodes[index]),
                                    );
                                    final engine = WidgetsFlutterBinding.ensureInitialized();
                                    engine.performReassemble();
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 32,),

                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            LocaleKeys.sure_logout.tr(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(LocaleKeys.no.tr()),
                            ),
                            TextButton(
                              onPressed: () {
                                authProvider.logout();
                                Navigator.of(context).pop();
                              },
                              child: Text(LocaleKeys.yes.tr()),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Color(0x40FF0000),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.logout.tr(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32,),
              ],
            ),
          ),
        );
      },
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
}