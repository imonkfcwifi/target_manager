import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:target_manager/constants/gaps.dart';

class InfoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '타겟 매니저 Beta 1.0 활용법',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            "1. 타겟매니저는 1부터 10까지로 이루어진 NumberPad로 구성되어있습니다",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          Gaps.v10,
          Text(
            "2. NumberPad를 눌러 기록하고 저장하여 슈팅기록에 기록할 수 있습니다",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          Gaps.v10,
          Text(
            "3. NumberPad를 길게 누를 시 누른 Number만큼 점수가 차감됩니다",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          Gaps.v10,
          Text(
            "4. NumberPad에서 취소를 누를 시 최근 기록된 점수가 차감됩니다",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          Gaps.v10,
          Text(
            "5. 최근 전공공부로 바빠서 업데이트가 늦어질 수 있습니다",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          Gaps.v10,
          Text(
            "",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
