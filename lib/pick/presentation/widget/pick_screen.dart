import 'package:drink_picker/pick/application/bloc/watcher/pick_event.dart';
import 'package:drink_picker/pick/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PickScreen extends ConsumerWidget {
  const PickScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            ref
                .read(pickStateNotifierProvider.notifier)
                .mapEventToState(PickEvent.pick(index));
          },
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.primaries[index],
            ),
            child: Text('Index:$index'),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemCount: 4,
    );
  }
}
