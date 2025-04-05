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
      builder: (context) => const BlueModal(),
    );
  }

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
        spacing: 40,
        children: [
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'Enter text',
              border: OutlineInputBorder(),
            ),
            onChanged: viewModel.setInputText,
          ),
          SwitchListTile(
            value: state.isSwitchOn,
            title: const Text('Switch'),
            onChanged: viewModel.setSwitch,
          ),
          ElevatedButton(
            onPressed: viewModel.setSelectedItems,
            style: state.selectedItems.isNotEmpty
                ? ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  )
                : null,
            child: const Text('Select Items'),
          ),
          ElevatedButton(
            onPressed: state.isDoneEnabled
                ? () {
                    final result = viewModel.getResult();
                    Navigator.pop(context, result);
                  }
                : null,
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
