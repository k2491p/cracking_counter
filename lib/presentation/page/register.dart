import 'package:cracking_counter/presentation/component/body_part_card.dart';
import 'package:cracking_counter/presentation/component/list_divider.dart';
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
                    if (index != 0) const ListDivider(),
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
                              const ListDivider(),
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
