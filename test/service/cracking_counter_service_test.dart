import 'package:cracking_counter/application/dto/cracking_counters.dart';
import 'package:cracking_counter/application/service/cracking_counter_service.dart';
import 'package:cracking_counter/application/shared.dart';
import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/domain/repository/i_cracking_counter_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';
import '../data/data.dart';
import 'cracking_counter_service_test.mocks.dart';

@GenerateMocks([ICrackingCounterRepository])
void main() {
  final repository = MockICrackingCounterRepository();
  String userId = "";
  setUp(() {
    var uuid = const Uuid();
    userId = uuid.v4();
    Shared.userId = userId;
  });
  group('GET', ()
  {
    test("一覧取得", () async {
      var list = Data.GetCrackingCounterList(userId);
      var crackingCounters = CrackingCounters(list);
      when(repository.getAll(userId)).thenAnswer((_) async => list);

      var service = CrackingCounterService.repository(repository);
      var result = await service.getCrackingCounters();

      expect(result, crackingCounters.value);
    });

    test("子要素設定", () async {
      var list = Data.GetCrackingCounterList(userId);
      var service = CrackingCounterService();
      var result = service.setChildren(list);

      expect(result.length, 3);
      expect(result[0].children.length, 0);
      expect(result[1].children.length, 0);
      expect(result[2].children.length, 5);
    });
  });

  group('INSERT', (){
    test("骨ポキ登録", () async {
      var list = Data.GetCrackingCounterList(userId);

      var service = CrackingCounterService.repository(repository);
      var success = true;
      try {
        service.register(list[0].bodyPartId);
      }
      catch (ex) {
        success = false;
      }
      expect(success, true);
    });
  });
}

