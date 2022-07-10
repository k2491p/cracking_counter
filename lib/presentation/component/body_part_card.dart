import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/presentation/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyPartCard extends StatelessWidget {
  const BodyPartCard({
    Key? key,
    required this.target,
    required this.vm, required this.isChildren,
  }) : super(key: key);

  final CrackingCounterEntity target;
  final RegisterViewModel vm;
  final bool isChildren;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: isChildren ? 60.w : 72.w,
          child: Text(
              target.bodyPartName, style: TextStyle(
              fontSize: 20.0.sp, fontWeight: FontWeight.bold)),
        ),
        48.horizontalSpace,
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('通算', style: TextStyle(fontSize: 16.0.sp)),
              Text(target.totalCount.stringValue, style: TextStyle(fontSize: 16.0.sp)),
            ]
        ),
        24.horizontalSpace,
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('今日', style: TextStyle(fontSize: 16.0.sp)),
                Text(target.todayCount.stringValue, style: TextStyle(fontSize: 16.0.sp)),
              ]
          ),
        ),
        ElevatedButton(
          child: const Text('ポキッ'),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            vm.register(target.bodyPartId);
            await vm.updateList();
          },
        ),
      ],
    );
  }
}