part of 'modal.dart';

typedef _ModalController = ({
  bool isSwitchOn,
  Set<String> selectedItems,
  bool isDoneEnabled,
  TextEditingController textController,
  VoidCallback setSwitch,
  VoidCallback setSelectedItems,
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
  ref.listen(backgroundColorProvider, (_, __) {
    textController.clear();
    isSwitchOn.value = false;
    selectedItems.value = {};
  });

  // textController,selectedItems,isSwitchOnの値が編集されたら
  // isDoneEnabledの値をtrueにする
  useEffect(
    () {
      isDoneEnabled.value = textController.text.isNotEmpty &&
          isSwitchOn.value &&
          selectedItems.value.isNotEmpty;
      return null;
    },
    [textController, isSwitchOn.value, selectedItems.value],
  );
  // <- 値の変更を監視して、副作用の処理を定義

  // INFO: 状態の変更を行う関数を定義 ->
  /// isSwitchOnの入力
  void setSwitch() => isSwitchOn.value = !isSwitchOn.value;

  /// selectedItemsの入力
  void setSelectedItems() {
    final items = List<String>.generate(10, (index) => 'Item $index').toSet();
    selectedItems.value = items;
  }

  /// modalの結果を取得
  OrangeModalResult getResult() => (
        inputText: textController.text,
        isSwitchOn: isSwitchOn.value,
        selectedItems: selectedItems.value,
      );
  // <- 状態の変更を行う関数を定義

  // INFO: modalの状態、関数をを返す
  return (
    isSwitchOn: isSwitchOn.value,
    selectedItems: selectedItems.value,
    isDoneEnabled: isDoneEnabled.value,
    textController: textController,
    setSwitch: setSwitch,
    setSelectedItems: setSelectedItems,
    getResult: getResult,
  );
}
