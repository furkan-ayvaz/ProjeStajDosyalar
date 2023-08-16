import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/padding/custom_padding.dart';
import 'package:my_dictionary/route/route_enum.dart';
import 'package:my_dictionary/sign_in_up/model/user_model.dart';
import 'package:my_dictionary/sign_in_up/view_model/sign_up_view_model.dart';

import '../../constant/strings/strings.dart';
import 'custom_password_form_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends SignUpViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: ProjectPadding.defaultPadding,
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: ProjectPadding.onlyBottomPadding,
                        child: SignUpTextField(
                          controller: nameController,
                          validator: formNameValidator,
                          text: ProjectStrings.nameText,
                        )),
                    Padding(
                        padding: ProjectPadding.onlyBottomPadding,
                        child: SignUpTextField(
                            validator: formNameValidator,
                            controller: surnameController,
                            text: ProjectStrings.surnameText)),
                    Padding(
                        padding: ProjectPadding.onlyBottomPadding,
                        child: SignUpTextField(
                            controller: nicknameController,
                            validator: validatorIsUnique,
                            text: ProjectStrings.nickNameText)),
                    Padding(
                      padding: ProjectPadding.onlyBottomPadding,
                      child: PasswordFormField(
                        inputActionIsNext: true,
                        controller: passwordController,
                        validator: validatorPassword,
                        labelText: ProjectStrings.passwordText,
                      ),
                    ),
                    PasswordFormField(
                      controller: rPasswordController,
                      validator: validatorPassword,
                      labelText: ProjectStrings.rPasswordText,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    ElevatedButton.icon(
                        onPressed: () async {
                          bool isUniquec = await isUniqueNickname(nicknameController.text);
                          setState(() {
                            isUnique = isUniquec;
                          });
                          if (formKey.currentState!.validate()) {
                            User tempUser = User(
                              name: nameController.text,
                              surname: surnameController.text,
                              nickname: nicknameController.text,
                              password: passwordController.text,
                            );
                            final jsonUser = json.encode(tempUser.toJson());
                            bool isSignUp = await signUp(jsonUser, nicknameController.text);
                            final userKey = getUserKey();
                            isSignUp
                                ? Navigator.pushNamedAndRemoveUntil(
                                    context, RouteName.words.toRoute(), (route) => false,
                                    arguments: userKey)
                                : null;
                          }
                        },
                        icon: const Icon(Icons.save_rounded),
                        label: const Padding(
                          padding: ProjectPadding.textSymmetricPadding,
                          child: Text(ProjectStrings.signUpText),
                        ))
                  ],
                )),
          ),
        ));
  }
}

class SignUpTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String text;
  const SignUpTextField({
    required this.text,
    required this.controller,
    required this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: Text(text),
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.short_text_outlined),
      ),
    );
  }
}
