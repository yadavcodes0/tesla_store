import 'package:flutter/widgets.dart';
import 'package:tesla_store/state/tesla_store_controller.dart';

class TeslaStoreScope extends InheritedNotifier<TeslaStoreController> {
  const TeslaStoreScope({
    super.key,
    required TeslaStoreController controller,
    required super.child,
  }) : super(notifier: controller);

  static TeslaStoreController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<TeslaStoreScope>();
    assert(scope != null, 'TeslaStoreScope not found in widget tree');
    return scope!.notifier!;
  }
}
