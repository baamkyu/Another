import '../../common/const/color.dart';
import 'package:another_front_wear_os/screen/widget/distanace_bar_custom.dart';
import 'package:flutter/material.dart';

class DistanceBar extends StatefulWidget {
  final String name;
  final double pace;
  const DistanceBar({
    required this.pace,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  State<DistanceBar> createState() => _DistanceBarState(name: name);
}

class _DistanceBarState extends State<DistanceBar> {
  late final String name;
  double _progress = 0.0;

  _DistanceBarState({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: [
          Text(
            name,
            style: TextStyle(
                color: WHITE_COLOR,
                fontWeight: FontWeight.w700,
                fontSize: 14.0),
            textAlign: TextAlign.left,
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: PRIMARY_COLOR,
              inactiveTrackColor: WHITE_COLOR,
              trackHeight: 6.0,
              thumbShape: CustomSliderThumbCircle(
                thumbRadius: 20,
                min: 0,
                max: 100,
              ),
            ),
            child: Slider(
              // 현재값에 지금 거리를 넣어주면 됨
              value: widget.pace,
              min: 0,
              // 거리 widget.distance 넣어주면 될듯 함 상대방의 거리
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _progress = value;
                });
              },
            ),
          ),
        ])
      ],
    );
  }
}