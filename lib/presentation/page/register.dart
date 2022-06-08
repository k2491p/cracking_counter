import 'package:cracking_counter/presentation/component/footer.dart';
import 'package:cracking_counter/presentation/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Register extends HookConsumerWidget {
  Register({Key? key, required this.title}) : super(key: key);

  final String title;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(registerViewModelProvider);
    useEffect(() {
      Future(() {
        vm.updateList();
      });
    }, const []);
    // vm.updateList();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
        // height: 60,
        child:
        // state.isLoading
        //   ? null
        // :
        ListView.builder(
          itemCount: vm.crackingList.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                SizedBox(
                  width: 72,
                  child: Text(vm.crackingList[index].bodyPartName, style: TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 48),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('通算'),
                      Text(vm.crackingList[index].totalCount.stringValue),
                    ]
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('今日'),
                        Text(vm.crackingList[index].todayCount.stringValue),
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
                  onPressed: () {},
                ),
              ],
            );
          }
        ),
      ),
      bottomNavigationBar: Footer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => vm.updateList(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void setState(Null Function() param0) {}
}
