import 'package:custom_hook_sample/presentations/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part '_use_modal_controller.dart';

typedef OrangeModalResult = ({
  String inputText,
  bool isSwitchOn,
  Set<String> selectedItems,
});

class OrangeModal extends HookConsumerWidget {
  const OrangeModal({super.key});

  static Future<OrangeModalResult?> show(BuildContext context) async {
    return showModalBottomSheet<OrangeModalResult?>(
      context: context,
      showDragHandle: true,
      builder: (context) => const OrangeModal(),
    );
  }

  static const _itemIds = ['A', 'B', 'C'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modalController = _useModalController(ref);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 14,
        children: [
          const Text('Orange Modal'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: modalController.textController,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SwitchListTile(
            value: modalController.isSwitchOn,
            title: const Text('Switch'),
            onChanged: (_) => modalController.setSwitch(),
          ),
          Column(
            children: _itemIds.map((id) {
              return CheckboxListTile(
                value: modalController.selectedItems.contains(id),
                title: Text('Select Item $id'),
                onChanged: (_) => modalController.selectItem(id),
              );
            }).toList(),
          ),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: modalController.isDoneEnabled
                  ? () {
                      final result = modalController.getResult();
                      Navigator.pop(context, result);
                    }
                  : null,
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
