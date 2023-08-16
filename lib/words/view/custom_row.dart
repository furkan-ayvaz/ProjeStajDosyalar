import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/padding/custom_padding.dart';
import 'package:my_dictionary/constant/strings/strings.dart';

class CustomRow extends StatefulWidget {
  CustomRow({this.txt, super.key});
  String? txt;
  @override
  State<CustomRow> createState() => _CustomRowState();
}

class _CustomRowState extends State<CustomRow> {
  bool _isFirst = true;
  void _changeCrossFade() {
    setState(() {
      _isFirst = !_isFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _innerCustomIconButton(),
        Padding(
          padding: ProjectPadding.onlyLeftPadding,
          child: _innerAnimatedCrossFade(context),
        )
      ],
    );
  }

  AnimatedCrossFade _innerAnimatedCrossFade(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Text(
            widget.txt ?? ProjectStrings.dataNullText,
            style: Theme.of(context).textTheme.headline5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        secondChild: Text(
          ProjectStrings.textVisibleCharText,
          style: Theme.of(context).textTheme.headline5,
        ),
        crossFadeState: _isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 100));
  }

  IconButton _innerCustomIconButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        _changeCrossFade();
      },
      icon: Icon(
        _isFirst ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        size: 20,
      ),
    );
  }
}

class CustomRow2 extends StatefulWidget {
  CustomRow2({this.txt, super.key});
  String? txt;
  @override
  State<CustomRow2> createState() => _CustomRow2State();
}

class _CustomRow2State extends State<CustomRow2> {
  bool _isFirst = false;
  void _changeCrossFade() {
    setState(() {
      _isFirst = !_isFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(padding: ProjectPadding.onlyLeftPadding, child: _innerAnimatedCrossFade(context)),
        _innerIconButton()
      ],
    );
  }

  IconButton _innerIconButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        _changeCrossFade();
      },
      icon: Icon(
        _isFirst ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        size: 20,
      ),
    );
  }

  AnimatedCrossFade _innerAnimatedCrossFade(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Text(
            widget.txt ?? ProjectStrings.dataNullText,
            style: Theme.of(context).textTheme.headline5,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
        secondChild: Text(
          ProjectStrings.textVisibleCharText,
          style: Theme.of(context).textTheme.headline5,
        ),
        crossFadeState: _isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 100));
  }
}
