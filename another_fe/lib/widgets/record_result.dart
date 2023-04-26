import 'package:another/widgets/record_result_box.dart';
import 'package:flutter/material.dart';

import '../constant/color.dart';

class RecordResult extends StatelessWidget {
  const RecordResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: BLACK_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 200.0,
        child: Column(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RecordResultBox(
                    data: '1:00:00',
                    name: '시간',
                    textColor: YELLOW_COLOR,
                    recordColor: WHITE_COLOR,
                  ),
                  RecordResultBox(
                    data: '8000m',
                    name: '거리',
                    textColor: BLUE_COLOR,
                    recordColor: WHITE_COLOR,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RecordResultBox(
                    data: '1500kcal',
                    name: '총칼로리',
                    textColor: RED_COLOR,
                    recordColor: WHITE_COLOR,
                  ),
                  RecordResultBox(
                    data: '15:6/km',
                    name: '평균페이스',
                    textColor: GREEN_COLOR,
                    recordColor: WHITE_COLOR,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}