import 'package:drink_picker/connection/application/bloc/connect_event.dart';
import 'package:drink_picker/connection/application/bloc/connect_state.dart';
import 'package:drink_picker/connection/dependency_injection.dart';
import 'package:drink_picker/core/presentation/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectionScreen extends ConsumerStatefulWidget {
  const ConnectionScreen({super.key});

  @override
  ConsumerState<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends ConsumerState<ConnectionScreen> {
  final List<TextEditingController> _controllers = [];
  final fields = [192, 168, 0, 2, 9092];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < fields.length; i++) {
      final textController = TextEditingController(text: fields[i].toString());
      _controllers.add(textController);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool isLast(int other) => other > fields.length - 2;

  String get combinedUri {
    return _controllers.indexed.fold(
        'ws://',
        (previousValue, element) => isLast(element.$1)
            ? '${previousValue.substring(0, previousValue.length - 1)}:${element.$2.text}'
            : '$previousValue${element.$2.text}.');
  }

  String get buttonTitle {
    final state = ref.watch(connectStateNotifierProvider);
    if (state is ConnectWiredState) {
      return 'Disconnect';
    } else {
      return 'Connect';
    }
  }

  void _onPressed() {
    final state = ref.watch(connectStateNotifierProvider);
    if (state is ConnectWiredState) {
      ref
          .read(connectStateNotifierProvider.notifier)
          .mapEventToState(const ConnectEvent.disconnect());
    } else {
      ref
          .read(connectStateNotifierProvider.notifier)
          .mapEventToState(ConnectEvent.connect(Uri.parse(combinedUri)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              Assets.images.plaifCircleCrop.path,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '로봇 연결 하기',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          for (var i = 0; i < fields.length; i++)
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(isLast(i) ? 'Port' : 'Field $i'),
                const SizedBox(width: 20),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _controllers[i],
                    textInputAction:
                        isLast(i) ? TextInputAction.done : TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: isLast(i) ? 5 : 3,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 300),
            child: ElevatedButton(
              onPressed: _onPressed,
              child: Text(buttonTitle),
            ),
          ),
        ],
      ),
    );
  }
}
