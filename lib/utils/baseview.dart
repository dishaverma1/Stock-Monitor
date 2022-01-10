import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// BaseView-> Change Notifier class to manage state
class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T)? onModelReady;
  final T instanceModel;
  BaseView({
    required this.builder,
    this.onModelReady,
    required this.instanceModel,
  });
  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  T? model;
  @override
  void initState() {
    model = widget.instanceModel;
    widget.onModelReady!(model!);
    // if (widget.onModelReady != null) {
    //   widget.onModelReady!(model);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model!,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
