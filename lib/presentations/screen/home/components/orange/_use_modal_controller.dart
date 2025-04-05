part of 'modal.dart';

typedef _ModalController = ({
  bool isSwitchOn,
  Set<String> selectedItems,
  bool isDoneEnabled,
  TextEditingController textController,
  VoidCallback setSwitch,
  void Function(String itemId) selectItem,
  OrangeModalResult Function() getResult,
});

_ModalController _useModalController(WidgetRef ref) {
  // INFO: modalの状態を定義 ->
  final textController = useTextEditingController(text: '');
  final isSwitchOn = useState(false);
  final selectedItems = useState(<String>{});
  final isDoneEnabled = useState(false);
  // <- modalの状態を定義

  // INFO: 値の変更を監視して、副作用の処理を定義 ->
  // 背景色の変更を監視
  ref.listen(backgroundColorProvider, (_, __) {
    // 初期値に戻す
    textController.clear();
    isSwitchOn.value = false;
    selectedItems.value = {};
  });

  // textControllerの入力状態を監視
  final textIsNotEmpty = useListenableSelector(
    textController,
    () => textController.text.isNotEmpty,
  );

  // [textIsNotEmpty], [isSwitchOn], [selectedItems]の値を監視
  // 上記の3つが全て編集された場合はisDoneEnabledの値をtrueにする
  useEffect(
    () {
      isDoneEnabled.value =
          textIsNotEmpty && isSwitchOn.value && selectedItems.value.isNotEmpty;
      return null;
    },
    [textIsNotEmpty, isSwitchOn.value, selectedItems.value],
  );
  // <- 値の変更を監視して、副作用の処理を定義

  // INFO: 状態の変更を行う関数を定義 ->
  /// isSwitchOnの入力
  void setSwitch() => isSwitchOn.value = !isSwitchOn.value;

  /// itemを選択する
  void selectItem(String itemId) {
    final isSelected = selectedItems.value.contains(itemId);
    final updateItems = <String>{}..addAll(selectedItems.value);
    if (isSelected) {
      updateItems.remove(itemId);
    } else {
      updateItems.add(itemId);
    }
    selectedItems.value = updateItems;
  }

  /// modalの結果を取得
  OrangeModalResult getResult() => (
        inputText: textController.text,
        isSwitchOn: isSwitchOn.value,
        selectedItems: selectedItems.value,
      );
  // <- 状態の変更を行う関数を定義

  // INFO: modalの状態、関数を返す
  return (
    isSwitchOn: isSwitchOn.value,
    selectedItems: selectedItems.value,
    isDoneEnabled: isDoneEnabled.value,
    textController: textController,
    setSwitch: setSwitch,
    selectItem: selectItem,
    getResult: getResult,
  );
}
