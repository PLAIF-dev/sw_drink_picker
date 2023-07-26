import 'package:drink_picker/connection/application/bloc/connect_state_notifier.dart';
import 'package:drink_picker/connection/application/service/connect_service.dart';
import 'package:drink_picker/connection/dependency_injection.dart';
import 'package:drink_picker/connection/infrastructure/repository/connection_repository_fake_success_impl.dart';
import 'package:drink_picker/core/presentation/widget/home_screen.dart';
import 'package:drink_picker/pick/actor/application/bloc/pick_state_notifier.dart';
import 'package:drink_picker/pick/actor/application/service/pick_service.dart';
import 'package:drink_picker/pick/actor/infrastructure/repository/pick_repository_fake_impl.dart';
import 'package:drink_picker/pick/dependency_injection.dart';
import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_state_notifier.dart';
import 'package:drink_picker/pick/watcher/application/service/pick_watch_service.dart';
import 'package:drink_picker/pick/watcher/infrastructure/repository/pick_watch_repository_fake_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebugOrReleaseScreen extends StatelessWidget {
  const DebugOrReleaseScreen({super.key});

  void onTap(BuildContext context, Widget child) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => child),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => onTap(context, alwaysSuccessButton),
                child: const Text('Debug Mode: Succeed all commands'),
              ),
              // const SizedBox(height: 8),
              // ElevatedButton(
              //   onPressed: () => onTap(context, alwaysFailButton),
              //   child: const Text('Debug Mode: Fail all commands'),
              // ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => onTap(context, const HomeScreen()),
                child: const Text('Release Mode'),
              ),
            ],
          ),
        ),
      );
    } else {
      return const HomeScreen();
    }
  }

  Widget get alwaysSuccessButton {
    return ProviderScope(
      overrides: [
        // connection
        connectRepositoryProvider.overrideWithValue(
          const ConnectionRepositoryFakeSuccessImpl(),
        ),
        connectServiceProvider.overrideWith(
          (ref) => ConnectServiceImpl(
            ref.watch(connectRepositoryProvider),
          ),
        ),
        connectStateNotifierProvider.overrideWith(
          (ref) => ConnectStateNotifier(
            ref.watch(connectServiceProvider),
          ),
        ),

        // pick state watcher
        pickWatchRepositoryProvider.overrideWithValue(
          PickWatchRepositoryFakeImpl(),
        ),
        pickWatchServiceProvider.overrideWith(
          (ref) => PickWatchServiceImpl(
            ref.watch(pickWatchRepositoryProvider),
          ),
        ),
        pickWatchStateNotifierProvider.overrideWith(
          (ref) => PickWatchStateNotifier(
            ref.watch(pickWatchServiceProvider),
          ),
        ),

        // pick
        pickRepositoryProvider.overrideWith(
          (ref) => PickRepositoryFakeImpl(
            ref.watch(pickWatchRepositoryProvider)
                as PickWatchRepositoryFakeImpl,
          ),
        ),
        pickServiceProvider.overrideWith(
          (ref) => PickServiceImpl(
            ref.watch(pickRepositoryProvider),
          ),
        ),
        pickStateNotifierProvider.overrideWith(
          (ref) => PickStateNotifier(
            ref.watch(pickServiceProvider),
          ),
        ),
      ],
      child: const HomeScreen(isDebug: true),
    );
  }

  // Widget get alwaysFailButton {
  //   return ProviderScope(
  //     overrides: [
  //       connectRepositoryProvider.overrideWithValue(
  //         const ConnectionRepositoryFakeFailImpl(),
  //       ),
  //       connectServiceProvider.overrideWith(
  //         (ref) => ConnectServiceImpl(
  //           ref.watch(connectRepositoryProvider),
  //         ),
  //       ),
  //       connectStateNotifierProvider.overrideWith(
  //         (ref) => ConnectStateNotifier(
  //           ref.watch(connectServiceProvider),
  //         ),
  //       ),
  //     ],
  //     child: const HomeScreen(
  //       isDebug: true,
  //     ),
  //   );
  // }
}
