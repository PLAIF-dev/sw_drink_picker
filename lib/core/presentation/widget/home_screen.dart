import 'package:drink_picker/connection/application/bloc/connect_state.dart';
import 'package:drink_picker/connection/dependency_injection.dart';
import 'package:drink_picker/connection/presentation/widget/connection_screen.dart';
import 'package:drink_picker/pick/presentation/widget/pick_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildPageByState(ConnectState state) {
    if (state is ConnectWiredState) {
      return const PickScreen();
    } else {
      return const ConnectionScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.listen(
          connectStateNotifierProvider,
          (previous, current) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(current.message),
              ),
            );
          },
        );

        return Scaffold(
          body: Center(
            child: _buildPageByState(
              ref.watch(connectStateNotifierProvider),
            ),
          ),
        );
      },
    );
  }
}
