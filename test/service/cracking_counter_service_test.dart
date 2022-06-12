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
  test("一覧取得", () async {
    var uuid = const Uuid();
    var userId = uuid.v4();
    Shared.userId = userId;
    var list = Data.GetCrackingCounterList(userId);
    var crackingCounters = CrackingCounters(list);
    when(repository.getAll(userId)).thenAnswer((_) async => list);

    var service = CrackingCounterService.repository(repository);
    var result = await service.getCrackingCounters();

    expect(result, crackingCounters.value);
    var parentList = result.where((element) => element.children.length > 0).toList();
    expect(parentList.length, 1);
    expect(parentList[0].children.length, 5);
  });
}

