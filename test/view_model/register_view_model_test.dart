import 'package:cracking_counter/application/service/cracking_counter_service.dart';
import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/presentation/view_model/register_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';
import '../data/data.dart';
import 'register_view_model_test.mocks.dart';

@GenerateMocks([CrackingCounterService])
void main() {
  final service = MockCrackingCounterService();
  String userId = "";
  setUp(() {
    var uuid = const Uuid();
    userId = uuid.v4();
    Shared.userId = userId;
  });
  group('GET', ()
  {
    test("一覧取得", () async {
      var crackingList = Data.GetCrackingCounterList(userId);
      when(service.getCrackingCounters()).thenAnswer((_) async => crackingList);

      var vm = RegisterViewModel.service(service);
      await vm.updateList();

      expect(vm.crackingList, crackingList);
    });
  });

  group('INSERT', (){
    test("骨ポキ登録", () async {
      var list = Data.GetCrackingCounterList(userId);

      var vm = RegisterViewModel();
      var success = true;
      try {
        vm.register(list[0].bodyPartId);
      }
      catch (ex) {
        success = false;
      }
      expect(success, true);
    });
  });
}
