part of 'controlled.dart';

mixin ControllerCore on ChangeNotifier {
  bool _disposed = false;
  bool get disposed => _disposed;

  bool _initialized = false;
  bool get initialized => _initialized;

  late BuildContext _context;
  void set context(BuildContext context) => _context = context;

  BuildContext get context => _context;

  final _children = <ControllerCore>[];
  List<ControllerCore> get children => List.unmodifiable(_children);

  /// Called by [Controlled] widget
  /// before first widget [build] method invocation.
  ///
  /// # THIS METHOD SHOULD NOT BE ASYNC.
  ///
  /// Same as first invocation of widget's [didChangeDependencies].
  @mustCallSuper
  void init() {
    this._initialized = true;
  }

  @mustCallSuper
  // ignore: use_setters_to_change_properties
  void didChangeDependencies(BuildContext context) {
    this.context = context;
  }

  @mustCallSuper
  void update() {
    if (!disposed) notifyListeners();
  }

  @override
  @mustCallSuper
  void dispose() {
    _disposed = true;
    _children.clear();
    super.dispose();
  }
}

abstract class Controller extends ChangeNotifier with ControllerCore {}

abstract class ValueController<T> extends ValueNotifier<T?>
    with ControllerCore {
  ValueController([T? value]) : super(value);
}
