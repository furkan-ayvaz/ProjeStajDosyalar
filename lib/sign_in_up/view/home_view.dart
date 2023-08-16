import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_dictionary/constant/padding/custom_padding.dart';
import 'package:my_dictionary/route/route_enum.dart';
import 'package:my_dictionary/sign_in_up/view_model/home_view_model.dart';

import '../../constant/path/path_creator.dart';
import '../../constant/strings/strings.dart';
import 'custom_password_form_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: ProjectPadding.defaultPadding,
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: LottieBuilder.asset(LottieFileName.lottie_word.toPath())),
              Padding(
                padding: ProjectPadding.onlyTopPadding,
                child: _nickNameTextField(),
              ),
              Padding(
                padding: ProjectPadding.onlyTopPadding,
                child: PasswordFormField(
                  controller: controllerPassword,
                  validator: validatorPassword,
                  labelText: ProjectStrings.passwordText,
                ),
              ),
              const SizedBox(height: 70),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await loginFunc();
                      final userKey = await getUserKey();
                      isLogin
                          ? Navigator.of(context)
                              .pushNamedAndRemoveUntil(RouteName.words.toRoute(), (route) => false, arguments: userKey)
                          : null;
                    }
                  },
                  child: const Padding(
                    padding: ProjectPadding.buttonTextPadding,
                    child: Text(ProjectStrings.signInText),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.signUp.toRoute());
                  },
                  child: const Text(ProjectStrings.signUpText))
            ],
          ),
        ),
      ),
    ));
  }

  TextFormField _nickNameTextField() {
    return TextFormField(
      validator: validatorNickname,
      controller: controllerNickName,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.people_outline),
          label: Text(ProjectStrings.nickNameText),
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red))),
    );
  }
}
