import 'package:cracking_counter/application/dto/cracking_counters.dart';
import 'package:cracking_counter/application/service/cracking_counter_service.dart';
import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/presentation/view_model/register_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';
import 'register_view_model_test.mocks.dart';

@GenerateMocks([CrackingCounterService])
void main() {
  final service = MockCrackingCounterService();
  test("一覧取得", () {
    var uuid = const Uuid();
    var userId = uuid.v4();
    var entity1 = CrackingCounterEntity(uuid.v4(), userId, uuid.v4(), 10, 1);
    var entity2 = CrackingCounterEntity(uuid.v4(), userId, uuid.v4(), 15, 2);
    var crackingCounters = CrackingCounters([entity1, entity2]);
    when(service.getCrackingCounters()).thenReturn(crackingCounters);

    var vm = RegisterViewModel(service);

    expect(vm.crackingList, crackingCounters);
  });
}
