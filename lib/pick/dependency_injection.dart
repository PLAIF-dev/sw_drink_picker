import 'package:drink_picker/connection/dependency_injection.dart';
import 'package:drink_picker/pick/actor/application/bloc/pick_state.dart';
import 'package:drink_picker/pick/actor/application/bloc/pick_state_notifier.dart';
import 'package:drink_picker/pick/actor/application/service/pick_service.dart';
import 'package:drink_picker/pick/actor/domain/repository/pick_repository.dart';
import 'package:drink_picker/pick/actor/infrastructure/repository/pick_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pickStateNotifierProvider =
    StateNotifierProvider<PickStateNotifier, PickState>(
  (ref) => PickStateNotifier(
    ref.watch(pickServiceProvider),
  ),
);

final pickServiceProvider = Provider<PickService>(
  (ref) => PickServiceImpl(
    ref.watch(pickRepositoryProvider),
  ),
);

final pickRepositoryProvider = Provider<PickRepository>(
  (ref) => PickRepositoryImpl(
    ref.watch(communicationChannelProvider),
  ),
);
