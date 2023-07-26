import 'package:drink_picker/connection/application/bloc/connect_state.dart';
import 'package:drink_picker/connection/dependency_injection.dart';
import 'package:drink_picker/connection/presentation/widget/connection_screen.dart';
import 'package:drink_picker/pick/core/presentation/widget/pick_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.isDebug = false});

  final bool isDebug;

  Widget _buildPageByState(ConnectState state) {
    if (state is ConnectWiredState) {
      return const PickScreen();
    } else {
      return const ConnectionScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(connectStateNotifierProvider);

          ref.listen(
            connectStateNotifierProvider,
            (previous, current) {
              if (current is! ConnectConnectingState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(current.message),
                  ),
                );
              }
            },
          );

          return _buildPageByState(state);
        },
      ),
    );
  }
}
