import 'package:another/constant/text_style.dart';
import 'package:another/widgets/target_box.dart';
import 'package:flutter/material.dart';

import '../constant/color.dart';

class Target extends StatelessWidget {
  final String targetname;

  const Target({
    required this.targetname,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            targetname,
            style: MyTextStyle.twentyTextStyle,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: BLACK_COLOR,
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: BoxConstraints(
            minHeight: 80.0,
            minWidth: 320.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TargetBox(
                data: '',
                name: 'km',
                textColor: MAIN_COLOR,
                recordColor: SERVEONE_COLOR,
              ),
              TargetBox(
                data: '',
                name: '시간',
                textColor: MAIN_COLOR,
                recordColor: SERVEONE_COLOR,
              ),
              TargetBox(
                data: '',
                name: 'kacl',
                textColor: MAIN_COLOR,
                recordColor: SERVEONE_COLOR,
              ),
              TargetBox(
                data: '',
                name: '평균 페이스',
                textColor: MAIN_COLOR,
                recordColor: SERVEONE_COLOR,
              ),
            ],
          ),
        )
      ],
    );
  }
}