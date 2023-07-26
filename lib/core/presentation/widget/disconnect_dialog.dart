import 'package:flutter/material.dart';

class DisconnectDialog extends StatelessWidget {
  const DisconnectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 350,
            child: Material(
              elevation: 5,
              color: Theme.of(context).colorScheme.surface,
              surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '연결 해제',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const Center(
                        child: _AnimatedWifiIcon(
                      iconSize: 150,
                    )),
                    const SizedBox(height: 24),
                    const Text(
                      '로봇과의 연결을 해제합니다. 해제 후에는 음료를 얻을 수 없어요.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop<bool>(true);
                      },
                      child: const Text('연결 해제'),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '혹은',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 2),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop<bool>(false),
                      child: Text(
                        '취소',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedWifiIcon extends StatefulWidget {
  const _AnimatedWifiIcon({required this.iconSize});

  final double iconSize;

  @override
  State<_AnimatedWifiIcon> createState() => __AnimatedWifiIconState();
}

class __AnimatedWifiIconState extends State<_AnimatedWifiIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.wifi,
          size: widget.iconSize,
        ),
        FadeTransition(
          opacity: _controller.drive(
            CurveTween(
              curve: Curves.easeInOut,
            ),
          ),
          child: Icon(
            Icons.wifi_off,
            size: widget.iconSize,
          ),
        ),
      ],
    );
  }
}
