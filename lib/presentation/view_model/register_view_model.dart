import 'package:cracking_counter/application/dto/cracking_counters.dart';
import 'package:cracking_counter/application/service/cracking_counter_service.dart';
import 'package:cracking_counter/domain/entity/cracking_counter_entity.dart';
import 'package:cracking_counter/domain/value_object/body_part_id.dart';
import 'package:cracking_counter/presentation/view_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class RegisterViewModel extends ChangeNotifier {
  List<CrackingCounterEntity> _crackingList = [];
  late CrackingCounterService _service;
  List<CrackingCounterEntity> get crackingList => _crackingList;

  RegisterViewModel() : this.service(CrackingCounterService());
  RegisterViewModel.service(this._service) {
    updateList();
  }

  updateList() async {
    _crackingList = await _service.getCrackingCounters();
    notifyListeners();
  }

  void register(BodyPartId bodyPartId) {
    _service.register(bodyPartId);
  }
}

final registerViewModelProvider = ChangeNotifierProvider((ref) => RegisterViewModel());