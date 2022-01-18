import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'controller.dart';

typedef ControllerBuilder<T extends ControllerCore> = T Function(
    BuildContext context);
typedef ControlledWidgetBuilder<T extends ControllerCore> = Widget Function(
    BuildContext context, T controller);

class Controlled<T extends ControllerCore> extends StatefulWidget {
  final ControllerBuilder<T>? create;
  final T? controller;
  final ControlledWidgetBuilder<T> builder;

  /// When `true`, controlled widget will not rebuilt children
  /// on [Controller.update] method invocation.
  final bool update;

  /// If provide equals `true`, controller will be provided
  /// by [ChangeNotifierProvider].
  final bool provide;

  const Controlled({
    Key? key,
    required this.create,
    required this.builder,
    this.update = true,
    this.provide = false,
  })  : controller = null,
        super(key: key);

  const Controlled.value({
    Key? key,
    required this.controller,
    required this.builder,
    this.update = true,
    this.provide = false,
  })  : create = null,
        assert(controller != null, 'controller cannot be null'),
        super(key: key);

  @override
  _ControlledState<T> createState() => _ControlledState<T>();
}

class _ControlledState<T extends ControllerCore> extends State<Controlled<T>> {
  T? _controller;
  late bool _valueControlled;

  @override
  void didChangeDependencies() {
    /// Called only before first build
    if (_controller == null) {
      _valueControlled = widget.controller != null;
      _controller =
          _valueControlled ? widget.controller : widget.create!(context);

      if (!_controller!.initialized) {
        /// initialize controller
        _controller!
          ..context = context
          ..init()
          ..didChangeDependencies(context);
      }

      if (!widget.provide && widget.update) {
        _listen(_controller!);
      }
    } else {
      _controller!.didChangeDependencies(context);
    }
    super.didChangeDependencies();
  }

  void _unlisten() {
    _controller?.removeListener(_onChange);
  }

  void _listen(T controller) {
    ArgumentError.checkNotNull(controller, 'controller');

    controller.addListener(_onChange);
  }

  void _onChange() {
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller!.initialized) {
      throw StateError(
        'Controller (${_controller.runtimeType}) was '
        'not properly initialized. Did you forget to call'
        'super.init() method? Also, make sure that controlers\''
        'init method is NOT asynchronous.',
      );
    }
    _controller!.context = context;

    if (widget.provide == true) {
      return ChangeNotifierProvider<T>.value(
        value: _controller!,
        child: widget.update

            /// Consume controller to rebuilt widgets on every update callback
            ? Consumer<T>(
                builder: (context, controller, _) =>
                    widget.builder(context, controller),
              )

            /// Only provide controller without updating widgets
            : widget.builder(context, _controller!),
      );
    } else {
      return widget.builder(context, _controller!);
    }
  }

  @override
  void dispose() {
    _unlisten();

    /// dispose controller only if it was created by this widget
    if (!_valueControlled) {
      _controller!.dispose();
    }

    super.dispose();
  }
}
