import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/padding/custom_padding.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/words/viewModel/add_word_view_model.dart';

import 'word_text_form_field.dart';

class AddWordView extends StatefulWidget {
  const AddWordView({super.key});

  @override
  State<AddWordView> createState() => _AddWordViewState();
}

class _AddWordViewState extends AddWordViewModel {
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
                    child: WordTextField(
                      controller: wordTextController,
                      validator: formValidator,
                      labelText: ProjectStrings.enterWordText,
                    )),
                Padding(
                  padding: ProjectPadding.onlyBottomPadding,
                  child: WordTextField(
                    validator: formValidator,
                    controller: translateTextController,
                    labelText: ProjectStrings.enterTranslationText,
                  ),
                ),
                Padding(
                    padding: ProjectPadding.onlyBottomPadding,
                    child: WordTextField(
                        validator: formValidator,
                        controller: example1TextController,
                        labelText: ProjectStrings.enterExample1Text)),
                WordTextField(
                    validator: formValidator,
                    controller: example2TextController,
                    labelText: ProjectStrings.enterExample2Text),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                ElevatedButton.icon(
                    label: const Text(ProjectStrings.saveWordText),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        tempWord?.key = ProjectStrings.wordNullText;
                        tempWord?.txtFirst = wordTextController.text;
                        tempWord?.txtSecond = translateTextController.text;
                        tempWord?.txtFirstExample = example1TextController.text;
                        tempWord?.txtSecondExample = example2TextController.text;
                        tempWord?.userNick = await getNickname();
                        tempWord?.userKey = await getUserKey();
                        final jsonMap = tempWord?.toJson();
                        final newjsonMap = json.encode(jsonMap);
                        bool isAdded = await addWord(newjsonMap);
                        if (isAdded) {
                          Navigator.pop(context, true);
                        }
                      }
                    },
                    icon: const Icon(Icons.save))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
