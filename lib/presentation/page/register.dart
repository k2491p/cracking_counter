import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/presentation/component/footer.dart';
import 'package:cracking_counter/presentation/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
        child:
        ListView.builder(
          itemCount: vm.crackingList.length,
          itemBuilder: (BuildContext context, int index) {
            var target = vm.crackingList[index];
            if (target.children.isEmpty) {
              return BodyPartCard(target: target, vm: vm);
            } else {
              return ExpansionTile(title: Text(target.bodyPartName),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: target.children.length,
                    itemBuilder: (BuildContext contextChild, int indexChild) {
                      var children = target.children[indexChild];
                      return BodyPartCard(target: children, vm: vm);
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
    required this.vm,
  }) : super(key: key);

  final CrackingCounterEntity target;
  final RegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
              target.bodyPartName, style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 48),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('通算'),
              Text(target.totalCount.stringValue),
            ]
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('今日'),
                Text(target.todayCount.stringValue),
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
