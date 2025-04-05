import 'package:custom_hook_sample/presentations/provider.dart';
import 'package:custom_hook_sample/presentations/screen/home/components/blue/modal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.freezed.dart';
part 'view_model.g.dart';

@freezed
class BlueModalState with _$BlueModalState {
  const factory BlueModalState({
    @Default(false) bool isSwitchOn,
    @Default({}) Set<String> selectedItems,
  }) = _BlueModalState;
}

@riverpod
class BlueModalViewModel extends _$BlueModalViewModel {
  @override
  BlueModalState build() {
    // 背景色の変更を監視
    final subscription = ref.listen(backgroundColorProvider, (_, __) {
      // 初期値に戻す
      state = const BlueModalState();
    });
    // 自身が破棄された時に、subscriptionをcloseする
    ref.onDispose(subscription.close);
    return const BlueModalState();
  }

  /// isSwitchOnの入力
  void setSwitch() => state = state.copyWith(isSwitchOn: !state.isSwitchOn);

  /// itemを選択する
  void selectItem(String itemId) {
    final isSelected = state.selectedItems.contains(itemId);

    final updateItems = <String>{}..addAll(state.selectedItems);
    if (isSelected) {
      updateItems.remove(itemId);
    } else {
      updateItems.add(itemId);
    }

    state = state.copyWith(selectedItems: updateItems);
  }

  /// doneボタンを活性化させることができるかどうか
  bool isDoneEnabled({required bool textIsNotEmpty}) =>
      textIsNotEmpty && state.selectedItems.isNotEmpty;

  /// modalの結果を取得
  BlueModalResult getResult(String inputText) => (
        inputText: inputText,
        isSwitchOn: state.isSwitchOn,
        selectedItems: state.selectedItems
      );
}
