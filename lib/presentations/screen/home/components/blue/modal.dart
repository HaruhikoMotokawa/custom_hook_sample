import 'package:custom_hook_sample/presentations/provider.dart';
import 'package:custom_hook_sample/presentations/screen/home/components/blue/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef BlueModalResult = ({
  String inputText,
  bool isSwitchOn,
  Set<String> selectedItems,
});

class BlueModal extends HookConsumerWidget {
  const BlueModal({super.key});

  static Future<BlueModalResult?> show(BuildContext context) async {
    return showModalBottomSheet<BlueModalResult?>(
      context: context,
      showDragHandle: true,
      builder: (context) => const BlueModal(),
    );
  }

  static const _itemIds = ['A', 'B', 'C'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = blueModalViewModelProvider;
    final state = ref.watch(provider);
    final viewModel = ref.read(provider.notifier);

    final textController = useTextEditingController(text: state.inputText);

    ref.listen(backgroundColorProvider, (_, __) {
      textController.clear();
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 14,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
              onChanged: viewModel.setInputText,
            ),
          ),
          SwitchListTile(
            value: state.isSwitchOn,
            title: const Text('Switch'),
            onChanged: (_) => viewModel.setSwitch(),
          ),
          CheckboxListTile(
            value: state.selectedItems.contains(_itemIds[0]),
            title: const Text('Select Item A'),
            onChanged: (_) => viewModel.setSelectedItems(_itemIds[0]),
          ),
          CheckboxListTile(
            value: state.selectedItems.contains(_itemIds[1]),
            title: const Text('Select Item B'),
            onChanged: (_) => viewModel.setSelectedItems(_itemIds[1]),
          ),
          CheckboxListTile(
            value: state.selectedItems.contains(_itemIds[2]),
            title: const Text('Select Item C'),
            onChanged: (_) => viewModel.setSelectedItems(_itemIds[2]),
          ),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: state.isDoneEnabled
                  ? () {
                      final result = viewModel.getResult();
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
