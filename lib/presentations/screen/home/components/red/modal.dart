import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RedModal extends HookWidget {
  const RedModal({super.key});

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => const RedModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAppleSwitch = useState(false);

    final bananaSwitchController = useBananaSwitchController();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 40,
        children: [
          SwitchListTile(
            value: isAppleSwitch.value,
            onChanged: (value) => isAppleSwitch.value = value,
            title: const Text('Apple Switch'),
          ),
          SwitchListTile(
            value: bananaSwitchController.isBananaSwitch,
            onChanged: (_) => bananaSwitchController.setBananaSwitch(),
            title: const Text('Banana Switch'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('close'),
          ),
        ],
      ),
    );
  }
}

typedef BananaSwitchController = ({
  bool isBananaSwitch,
  void Function() setBananaSwitch,
});

BananaSwitchController useBananaSwitchController() {
  final isBananaSwitch = useState(false);

  void setBananaSwitch() => isBananaSwitch.value = !isBananaSwitch.value;

  return (
    isBananaSwitch: isBananaSwitch.value,
    setBananaSwitch: setBananaSwitch,
  );
}

// (bool, void Function()) useBananaSwitchController() {
//   final isBananaSwitch = useState(false);

//   void setBananaSwitch() => isBananaSwitch.value = !isBananaSwitch.value;

//   return (
//     isBananaSwitch.value,
//     setBananaSwitch,
//   );
// }
