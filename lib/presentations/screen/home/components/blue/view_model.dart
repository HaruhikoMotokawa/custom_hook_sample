import 'package:custom_hook_sample/presentations/provider.dart';
import 'package:custom_hook_sample/presentations/screen/home/components/blue/modal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.freezed.dart';
part 'view_model.g.dart';

@freezed
class BlueModalState with _$BlueModalState {
  const factory BlueModalState({
    @Default('') String inputText,
    @Default(false) bool isSwitchOn,
    @Default({}) Set<String> selectedItems,
  }) = _BlueModalState;

  const BlueModalState._();

  // 全ての値がからではない時にdoneを押せるようにする
  bool get isDoneEnabled =>
      inputText.isNotEmpty && isSwitchOn && selectedItems.isNotEmpty;
}

@riverpod
class BlueModalViewModel extends _$BlueModalViewModel {
  @override
  BlueModalState build() {
    final subscription = ref.listen(backgroundColorProvider, (_, __) {
      // 初期値に戻す
      state = const BlueModalState();
    });

    ref.onDispose(subscription.close);
    return const BlueModalState();
  }

  void setInputText(String text) {
    state = state.copyWith(inputText: text);
  }

  void setSwitch() {
    state = state.copyWith(isSwitchOn: !state.isSwitchOn);
  }

  void setSelectedItems(String itemId) {
    final isSelected = state.selectedItems.contains(itemId);
    final updateItems = <String>{};
    if (isSelected) {
      updateItems
        ..addAll(state.selectedItems)
        ..remove(itemId);
    } else {
      updateItems
        ..addAll(state.selectedItems)
        ..add(itemId);
    }
    state = state.copyWith(selectedItems: updateItems);
  }

  BlueModalResult getResult() => (
        inputText: state.inputText,
        isSwitchOn: state.isSwitchOn,
        selectedItems: state.selectedItems
      );
}
