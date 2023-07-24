import 'package:drink_picker/pick/actor/application/bloc/pick_event.dart';
import 'package:drink_picker/pick/dependency_injection.dart';
import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PickScreen extends ConsumerStatefulWidget {
  const PickScreen({super.key});

  @override
  ConsumerState<PickScreen> createState() => _PickScreenState();
}

class _PickScreenState extends ConsumerState<PickScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref
        .read(pickWatchStateNotifierProvider.notifier)
        .mapEventToState(const PickWatchEvent.watchIoChanges());
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
