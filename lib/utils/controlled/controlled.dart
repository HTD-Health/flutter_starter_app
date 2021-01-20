import 'package:flutter/material.dart';

typedef ControllerBuilder<T extends ChangeNotifier> = T Function(
    BuildContext context);
typedef ControlledWidgetBuilder<T extends ChangeNotifier> = Widget Function(
    BuildContext context, T controller);

class Controlled<T extends ChangeNotifier> extends StatefulWidget {
  final T controller;
  final ControllerBuilder<T> create;
  final ControlledWidgetBuilder<T> builder;

  const Controlled.value({
    Key key,
    @required this.controller,
    @required this.builder,
  })  : create = null,
        assert(controller != null, 'controller cannot be null'),
        assert(builder != null, 'builder cannot be null'),
        super(key: key);

  const Controlled({
    Key key,
    this.create,
    @required this.builder,
  })  : controller = null,
        assert(create != null, 'create cannot be null'),
        assert(builder != null, 'builder cannot be null'),
        super(key: key);

  @override
  _ControlledState<T> createState() => _ControlledState<T>();
}

class _ControlledState<T extends ChangeNotifier> extends State<Controlled<T>> {
  T _controller;

  @override
  void didChangeDependencies() {
    /// Called only before first build
    if (_controller == null) {
      if (widget.controller != null) {
        _listen(widget.controller);
      } else {
        _listen(widget.create(context));
      }
    }

    super.didChangeDependencies();
  }

  void _unlisten() {
    _controller?.removeListener(_onChange);
  }

  void _listen(T controller) {
    ArgumentError.checkNotNull(controller, 'controller');
    if (_controller == controller) {
      throw ArgumentError.value(
        controller,
        'controller',
        'Already listening to controller.',
      );
    }

    _controller = controller..addListener(_onChange);
  }

  void _onChange() => setState(() {});

  @override
  Widget build(BuildContext context) => widget.builder(context, _controller);

  @override
  void dispose() {
    /// dispose controller only if it was created by this widget
    if (widget.create != null) {
      _unlisten();
      _controller.dispose();
    }
    super.dispose();
  }
}
