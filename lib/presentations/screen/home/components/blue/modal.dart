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
    final state = ref.watch(blueModalViewModelProvider);
    final viewModel = ref.read(blueModalViewModelProvider.notifier);

    final textController = useTextEditingController(text: '');
    final textIsNotEmpty = useListenableSelector(
      textController,
      () => textController.text.isNotEmpty,
    );

    ref.listen(backgroundColorProvider, (_, __) {
      textController.clear();
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 14,
        children: [
          const Text('Blue Modal'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SwitchListTile(
            value: state.isSwitchOn,
            title: const Text('Switch'),
            onChanged: (_) => viewModel.setSwitch(),
          ),
          Column(
            children: _itemIds.map((id) {
              return CheckboxListTile(
                value: state.selectedItems.contains(id),
                title: Text('Select Item $id'),
                onChanged: (_) => viewModel.selectItem(id),
              );
            }).toList(),
          ),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: viewModel.isDoneEnabled(textIsNotEmpty: textIsNotEmpty)
                  ? () {
                      final result = viewModel.getResult(textController.text);
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
