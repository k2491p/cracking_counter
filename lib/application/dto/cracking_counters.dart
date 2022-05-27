import 'package:flutter/foundation.dart';

import '../../domain/entity/cracking_counter_entity.dart';

class CrackingCounters {
  List<CrackingCounterEntity> value;
  CrackingCounters(this.value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is CrackingCounters && listEquals(value, other.value)) return true;
    return false;
  }
}
