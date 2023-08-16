import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/border/custom_border.dart';
import 'package:my_dictionary/constant/padding/custom_padding.dart';
import 'package:my_dictionary/constant/strings/strings.dart';
import 'package:my_dictionary/route/route_enum.dart';
import 'package:my_dictionary/words/view/word_detail_view_body.dart';
import 'package:my_dictionary/words/viewModel/word_detail_view_model.dart';

import '../model/word_model.dart';

class WordDeatilView extends StatefulWidget {
  const WordDeatilView({required this.word, super.key});
  final Word? word;
  @override
  State<WordDeatilView> createState() => _WordDeatilViewState();
}

class _WordDeatilViewState extends WordDetailViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: isLoading
            ? [const Center(child: CircularProgressIndicator())]
            : isOwner
                ? [
                    IconButton(
                        onPressed: () {
                          controllerWord.text = widget.word?.txtFirst ?? ProjectStrings.wentWrongText;
                          controllerTranslate.text = widget.word?.txtSecond ?? ProjectStrings.wentWrongText;
                          controllerWordSentencte.text = widget.word?.txtFirstExample ?? ProjectStrings.wentWrongText;
                          controllerTranslateSentence.text =
                              widget.word?.txtSecondExample ?? ProjectStrings.wentWrongText;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  actionsPadding:
                                      EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.06, bottom: 20),
                                  shape: RoundedRectangleBorder(borderRadius: ProjectBorder.wordDetailBorderRadius),
                                  elevation: 5,
                                  scrollable: true,
                                  contentPadding: ProjectPadding.wordDetailSymmetricPadding,
                                  title: const Text(ProjectStrings.updateWordText),
                                  actions: [
                                    ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.cancel_outlined),
                                        label: const Text(ProjectStrings.cancelText)),
                                    ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                        onPressed: () async {
                                          if (formKey.currentState!.validate()) {
                                            final newWord = widget.word?.copyWith(
                                                txtFirst: controllerWord.text,
                                                txtSecond: controllerTranslate.text,
                                                txtFirstExample: controllerWordSentencte.text,
                                                txtSecondExample: controllerTranslateSentence.text);
                                            final jsonWord = json.encode(newWord?.toJson());
                                            isUpdate =
                                                await updateWord(newWord?.key ?? ProjectStrings.nullText, jsonWord);
                                            if (isUpdate) {
                                              final userKey = getUserKey();
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context, RouteName.words.toRoute(), (route) => false,
                                                  arguments: userKey);
                                            }
                                          }
                                        },
                                        icon: const Icon(Icons.check_rounded),
                                        label: const Text(ProjectStrings.updateText))
                                  ],
                                  content: Form(
                                    key: formKey,
                                    child: Padding(
                                      padding: ProjectPadding.defaultPadding,
                                      child: Column(children: [
                                        Padding(
                                          padding: ProjectPadding.onlyBottomPadding,
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.7,
                                            child: TextFormField(
                                              validator: formValidator,
                                              controller: controllerWord,
                                              textInputAction: TextInputAction.next,
                                              decoration: const InputDecoration(
                                                  label: Text(ProjectStrings.yourWordText),
                                                  border: OutlineInputBorder()),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: ProjectPadding.onlyBottomPadding,
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.7,
                                            child: TextFormField(
                                              validator: formValidator,
                                              controller: controllerTranslate,
                                              textInputAction: TextInputAction.next,
                                              decoration: const InputDecoration(
                                                  label: Text(ProjectStrings.translateYourWordText),
                                                  border: OutlineInputBorder()),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: ProjectPadding.onlyBottomPadding,
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.7,
                                            child: TextFormField(
                                              validator: formValidator,
                                              controller: controllerWordSentencte,
                                              textInputAction: TextInputAction.next,
                                              decoration: const InputDecoration(
                                                  label: Text(ProjectStrings.sentenceWithWordText),
                                                  border: OutlineInputBorder()),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: TextFormField(
                                            validator: formValidator,
                                            controller: controllerTranslateSentence,
                                            decoration: const InputDecoration(
                                                label: Text(ProjectStrings.enterExample2Text),
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ));
                            },
                          );
                        },
                        icon: const Icon(Icons.edit_rounded)),
                    IconButton(
                        onPressed: () async {
                          isDelete = await deleteWord(widget.word?.key ?? ProjectStrings.nullText);
                          if (isDelete) {
                            final userKey = getUserKey();
                            Navigator.pushNamedAndRemoveUntil(context, RouteName.words.toRoute(), (route) => false,
                                arguments: userKey);
                          } else {
                            null;
                          }
                        },
                        icon: const Icon(Icons.delete_forever_outlined)),
                  ]
                : null,
      ),
      body: WordDetailViewBody(word: widget.word),
    );
  }
}
