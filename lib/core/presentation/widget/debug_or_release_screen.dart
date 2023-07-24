import 'package:drink_picker/connection/application/bloc/connect_state_notifier.dart';
import 'package:drink_picker/connection/application/service/connect_service.dart';
import 'package:drink_picker/connection/dependency_injection.dart';
import 'package:drink_picker/connection/infrastructure/repository/connection_repository_fake_fail_impl.dart';
import 'package:drink_picker/connection/infrastructure/repository/connection_repository_fake_success_impl.dart';
import 'package:drink_picker/core/presentation/widget/home_screen.dart';
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
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () => onTap(context, alwaysFailButton),
                child: const Text('Debug Mode: Fail all commands'),
              ),
              const SizedBox(height: 4),
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
        connectRepositoryProvider.overrideWithValue(
          ConnectionRepositoryFakeSuccessImpl(),
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
      ],
      child: const HomeScreen(),
    );
  }

  Widget get alwaysFailButton {
    return ProviderScope(
      overrides: [
        connectRepositoryProvider.overrideWithValue(
          ConnectionRepositoryFakeFailImpl(),
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
      ],
      child: const HomeScreen(),
    );
  }
}
