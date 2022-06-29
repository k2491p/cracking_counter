import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/presentation/component/footer.dart';
import 'package:cracking_counter/presentation/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Register extends HookConsumerWidget {
  Register({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(registerViewModelProvider);
    useEffect(() {
      Future(() {
        vm.updateList();
      });
    }, const []);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 24.0.w),
        child:
        ListView.builder(
          itemCount: vm.crackingList.length,
          itemBuilder: (BuildContext context, int index) {
            var target = vm.crackingList[index];
            if (target.children.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 6.0.w),
                child: Column(
                  children: [
                    if (index != 0) Divider(color: Colors.grey, thickness: 1.0, height: 1.0.h),
                    BodyPartCard(target: target, vm: vm, isChildren: false,),
                  ],
                )
              );
            } else {
              return ExpansionTile(
                title: Text(target.bodyPartName,
                    style: TextStyle(
                      fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold)
                    ,

                ),
                tilePadding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 6.0.w),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: target.children.length,
                    itemBuilder: (BuildContext contextChild, int indexChild) {
                      var children = target.children[indexChild];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 6.0.w),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            children: [
                              Divider(color: Colors.grey, thickness: 1.0, height: 1.0.h),
                              BodyPartCard(target: children, vm: vm, isChildren: true,),
                            ],
                          ),
                        ),
                      );
                    }
                  )
                ],
              );
            }
          }
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }

}

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
