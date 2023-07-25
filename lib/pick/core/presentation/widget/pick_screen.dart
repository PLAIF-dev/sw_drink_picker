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
        .mapEventToState(const PickWatchEvent.subscribeChanges());
  }

  @override
  void deactivate() {
    ref
        .read(pickWatchStateNotifierProvider.notifier)
        .mapEventToState(const PickWatchEvent.unsubscribe());

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            left: 4.0,
            right: 4.0,
            top: 4.0,
            bottom: 4.0,
            child: ListView.separated(
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
            ),
          ),
        ],
      ),
    );
  }
}
