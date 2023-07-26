// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:drink_picker/connection/application/bloc/connect_event.dart';
import 'package:drink_picker/connection/dependency_injection.dart';
import 'package:drink_picker/core/presentation/extension/color_extension.dart';
import 'package:drink_picker/core/presentation/generated/assets.gen.dart';
import 'package:drink_picker/core/presentation/widget/disconnect_dialog.dart';
import 'package:drink_picker/pick/actor/application/bloc/pick_event.dart';
import 'package:drink_picker/pick/dependency_injection.dart';
import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_event.dart';
import 'package:drink_picker/pick/watcher/application/bloc/pick_watch_state.dart';

class PickScreen extends ConsumerStatefulWidget {
  const PickScreen({super.key});

  @override
  ConsumerState<PickScreen> createState() => _PickScreenState();
}

class _PickScreenState extends ConsumerState<PickScreen> {
  static const itemCount = 4;
  static const space = 20.0;

  bool isInitialized = false;
  bool _canExecute = false;

  /// 혹시나 여러번 클릭 되는 경우를 방지하기 위해 설정값으로 사용
  /// [_onTap] 에서 400 밀리초 텀을 두고 call 할 수 있게 함
  bool didClickSoFast = false;

  int? _workingLaneIndex;

  // ! Ad-hoc
  /// - Use Case 가 다음 4가지 경우 밖에 없기 때문에 임의로 작성
  final drinks = <DrinkViewModel>[
    DrinkViewModel(
        name: '스프라이트',
        imagePath: Assets.images.sprite.path,
        backgroundColor: const Color(0xFF00C285)),
    DrinkViewModel(
        name: '밀크소다',
        imagePath: Assets.images.milkSoda.path,
        backgroundColor: const Color(0xFFA8BFEB)),
    DrinkViewModel(
        name: '웰치스',
        imagePath: Assets.images.welchs.path,
        backgroundColor: const Color(0xFFBB93FF)),
    DrinkViewModel(
        name: '코카콜라',
        imagePath: Assets.images.coke.path,
        backgroundColor: const Color(0xFFFF785E)),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref
        .read(pickWatchStateNotifierProvider.notifier)
        .mapEventToState(const PickWatchEvent.subscribeWatch());
  }

  @override
  void deactivate() {
    ref
        .read(pickWatchStateNotifierProvider.notifier)
        .mapEventToState(const PickWatchEvent.unsubscribe());

    super.deactivate();
  }

  bool _isHighlighted(int index) {
    if (!isInitialized) {
      return false;
    }

    if (_workingLaneIndex == null) {
      return true;
    }

    if (index != _workingLaneIndex) {
      return false;
    } else {
      return true;
    }
  }

  bool canExecuteAt(int index) {
    if (!_canExecute) {
      return false;
    }

    if (_workingLaneIndex == null) {
      return true;
    }

    if (index != _workingLaneIndex) {
      return false;
    }

    return true;
  }

  void _onTap(int index) {
    if (didClickSoFast) {
      return;
    }

    didClickSoFast = true;
    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        didClickSoFast = false;
      },
    );

    if (canExecuteAt(index)) {
      ref
          .read(pickStateNotifierProvider.notifier)
          .mapEventToState(PickEvent.pick(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    _changeAppStateByMachineState();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              height: 30,
              child: Image.asset(
                Assets.images.plaifCircleCrop.path,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Drink Picker'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: IconButton.filledTonal(
              onPressed: () => showDialog<bool>(
                context: context,
                builder: (context) => const DisconnectDialog(),
              ).then((value) {
                if (value == null) return;

                if (value) {
                  ref
                      .read(connectStateNotifierProvider.notifier)
                      .mapEventToState(const ConnectEvent.disconnect());
                }
              }),
              icon: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.wifi_off_rounded),
              ),
              tooltip: '연결 끊기',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned.fill(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return LaneCard(
                        isActivated: _isHighlighted(index),
                        drink: drinks[index],
                        onTap: () => _onTap(index),
                        width: constraints.maxWidth / 4 -
                            space * (itemCount - 1) / itemCount,
                        height: double.infinity,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: space,
                    ),
                    itemCount: itemCount,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _changeAppStateByMachineState() {
    ref.listen(
      pickWatchStateNotifierProvider,
      (prev, current) {
        isInitialized = true;
        if (current is PickWatchBusyState) {
          _showMessageBox(
            context,
            (controller) => _buildMessageBox(
              controller,
              '${current.workingIndex + 1} 번째 라인에 있는 음료를 이동시키고 있습니다.',
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.secondaryContainer,
            ),
          );

          setState(() {
            _workingLaneIndex = current.workingIndex;
            _canExecute = false;
          });
        } else if (current is PickWatchReadyState) {
          _showMessageBox(
            context,
            (controller) => _buildMessageBox(
              controller,
              '음료를 뽑을 준비가 되었습니다. 원하는 음료를 골라주세요!',
              Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.tertiaryContainer,
            ),
          );

          setState(() {
            _workingLaneIndex = null;
            _canExecute = true;
          });
        } else if (current is PickWatchBlockedState) {
          _showMessageBox(
            context,
            (controller) => _buildMessageBox(
              controller,
              '음료를 운반하다 문제가 생겼습니다. 다시 한번 음료 버튼을 눌러 운반을 완료해주세요.',
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
            ),
          );

          setState(() {
            _workingLaneIndex = current.holdingIndex;
            _canExecute = true;
          });
        } else if (current is PickWatchFailedState) {
          _showMessageBox(
            context,
            (controller) => _buildMessageBox(
              controller,
              '문제가 발생했습니다.\n${current.failure.message}',
              Theme.of(context).colorScheme.error,
              Theme.of(context).colorScheme.onError,
            ),
          );
        }
      },
    );
  }

  void _showMessageBox(BuildContext context,
      FlashBar Function(FlashController) onFlashBarCreate) {
    context.showFlash<bool>(
      duration: const Duration(milliseconds: 3000),
      transitionDuration: const Duration(milliseconds: 1000),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      builder: (context, controller) {
        if (mounted) {
          return onFlashBarCreate(controller);
        }
        return const SizedBox();
      },
    );
  }

  FlashBar _buildMessageBox(FlashController controller, String message,
      Color textColor, Color backgroundColor) {
    return FlashBar(
      position: FlashPosition.top,
      controller: controller,
      forwardAnimationCurve: Curves.elasticOut,
      reverseAnimationCurve: Curves.elasticOut,
      clipBehavior: Clip.hardEdge,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      behavior: FlashBehavior.floating,
      content: Text(
        message,
        style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
      ),
    );
  }
}

class LaneCard extends StatelessWidget {
  const LaneCard({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.isActivated,
    required this.drink,
  });

  final double width;
  final double height;
  final VoidCallback? onTap;
  final bool isActivated;
  final DrinkViewModel drink;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActivated ? onTap : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: drink.backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 24,
                        right: 24,
                        top: 0,
                        bottom: 0,
                        child: Image.asset(
                          drink.imagePath,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Text(
                          drink.name,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: drink.backgroundColor.textColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 600),
                  offset: isActivated ? const Offset(0.0, -1.0) : Offset.zero,
                  curve: Curves.easeInOutQuart,
                  child: AnimatedOpacity(
                    opacity: isActivated ? 0 : 0.65,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrinkViewModel {
  const DrinkViewModel({
    required this.name,
    required this.imagePath,
    required this.backgroundColor,
  });

  final String name;
  final String imagePath;
  final Color backgroundColor;
}
