import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/padding/custom_padding.dart';
import 'package:my_dictionary/constant/strings/strings.dart';

import '../model/word_model.dart';

class WordDetailViewBody extends StatelessWidget {
  const WordDetailViewBody({
    Key? key,
    required this.word,
  }) : super(key: key);

  final Word? word;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ProjectPadding.defaultPadding2x,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  word?.txtFirst ?? ProjectStrings.dataNullText,
                  style: Theme.of(context).textTheme.headline5,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  word?.txtSecond ?? ProjectStrings.dataNullText,
                  style: Theme.of(context).textTheme.headline5,
                  maxLines: 2,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  word?.txtFirstExample ?? ProjectStrings.dataNullText,
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  word?.txtSecondExample ?? ProjectStrings.dataNullText,
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
