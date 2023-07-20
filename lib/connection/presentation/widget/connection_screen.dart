import 'package:drink_picker/connection/application/bloc/connect_event.dart';
import 'package:drink_picker/connection/dependency_injection.dart';
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

  static const _inputFieldCount = 5;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _inputFieldCount; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool isLast(int other) => other > _inputFieldCount - 2;

  String get combinedUri {
    return _controllers.indexed.fold(
        'ws://',
        (previousValue, element) => isLast(element.$1)
            ? '${previousValue.substring(0, previousValue.length - 1)}:${element.$2.text}'
            : '$previousValue${element.$2.text}.');
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      connectStateNotifierProvider,
      (previous, current) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(current.message),
        ));
      },
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('IP Address', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        for (var i = 0; i < _inputFieldCount; i++)
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(isLast(i) ? 'Port' : 'Field $i'),
              const SizedBox(width: 12),
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
        ElevatedButton(
          onPressed: () {
            ref
                .read(connectStateNotifierProvider.notifier)
                .mapEventToState(ConnectEvent.connect(Uri.parse(combinedUri)));
          },
          child: const Text('Connect'),
        ),
      ],
    );
  }
}
