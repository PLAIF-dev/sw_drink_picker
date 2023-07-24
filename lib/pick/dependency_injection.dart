import 'package:drink_picker/connection/dependency_injection.dart';
import 'package:drink_picker/pick/actor/application/bloc/pick_state.dart';
import 'package:drink_picker/pick/actor/application/bloc/pick_state_notifier.dart';
import 'package:drink_picker/pick/actor/application/service/pick_service.dart';
import 'package:drink_picker/pick/actor/domain/repository/pick_repository.dart';
import 'package:drink_picker/pick/actor/infrastructure/repository/pick_repository_impl.dart';
import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_state.dart';
import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_state_notifier.dart';
import 'package:drink_picker/pick/watcher/application/service/pick_watch_service.dart';
import 'package:drink_picker/pick/watcher/domain/repository/pick_watch_repository.dart';
import 'package:drink_picker/pick/watcher/infrastructure/repository/pick_watch_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// actor
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

/// watcher
final pickWatchStateNotifierProvider =
    StateNotifierProvider<PickWatchStateNotifier, PickWatchState>(
  (ref) => PickWatchStateNotifier(ref.watch(pickWatchServiceProvider)),
);

final pickWatchServiceProvider = Provider<PickWatchService>(
  (ref) => PickWatchServiceImpl(
    ref.watch(pickWatchRepositoryProvider),
  ),
);

final pickWatchRepositoryProvider = Provider<PickWatchRepository>(
  (ref) => PickWatchRepositoryImpl(
    ref.watch(communicationChannelProvider),
  ),
);
