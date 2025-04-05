import 'package:custom_hook_sample/presentations/provider.dart';
import 'package:custom_hook_sample/presentations/screen/home/components/blue/modal.dart';
import 'package:custom_hook_sample/presentations/screen/home/components/orange/modal.dart';
import 'package:custom_hook_sample/presentations/screen/home/components/red/modal.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Hook Sample'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: 40,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => RedModal.show(context),
                child: const Text('Simple Custom Hook'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await BlueModal.show(context);
                  if (result != null) {
                    final message = 'inputText: ${result.inputText}, '
                        'isSwitchOn: ${result.isSwitchOn}, '
                        'selectedItems: ${result.selectedItems}';

                    if (!context.mounted) return;
                    await _showBanner(context, message);
                  }
                },
                child: const Text('View Model'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await OrangeModal.show(context);
                  if (result != null) {
                    final message = 'inputText: ${result.inputText}, '
                        'isSwitchOn: ${result.isSwitchOn}, '
                        'selectedItems: ${result.selectedItems}';

                    if (!context.mounted) return;
                    await _showBanner(context, message);
                  }
                },
                child: const Text('Custom Hook'),
              ),
              const Divider(),
              Consumer(
                builder: (context, ref, child) {
                  final backgroundColor =
                      ref.watch(backgroundColorProvider).color;
                  return ElevatedButton(
                    onPressed: () => ref
                        .read(backgroundColorProvider.notifier)
                        .changeColor(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor,
                    ),
                    child: const Text('ChangeColor'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showBanner(BuildContext context, String message) async {
    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..clearMaterialBanners()
      ..showMaterialBanner(
        MaterialBanner(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: messenger.hideCurrentMaterialBanner,
              child: const Text('OK'),
            ),
          ],
        ),
      );
  }
}
