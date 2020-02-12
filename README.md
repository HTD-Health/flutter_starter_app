# flutter_starter_app

- [flutter_starter_app](#flutterstarterapp)
  - [1. Basic Commands](#1-basic-commands)
  - [2. How to BloC with Provider](#2-how-to-bloc-with-provider)
      - [2.1. Create BloC class](#21-create-bloc-class)
      - [2.2. Provide BloC object down the tree:](#22-provide-bloc-object-down-the-tree)
      - [2.3. Get access to BloC object from widgets placed down the tree](#23-get-access-to-bloc-object-from-widgets-placed-down-the-tree)
      - [2.4. **That's all**. Use methods on on your BloC objects and all will be updated!](#24-thats-all-use-methods-on-on-your-bloc-objects-and-all-will-be-updated)
  - [3. Project analysis options](#3-project-analysis-options)
  - [4. Json serialization](#4-json-serialization)
      - [4.1. To create JSON serialize create model file like:](#41-to-create-json-serialize-create-model-file-like)
      - [4.2. Run `flutter pub run build_runner build`](#42-run-flutter-pub-run-buildrunner-build)
      - [4.3. Thats all. To parse json:](#43-thats-all-to-parse-json)
  - [5. Api](#5-api)
  - [6. Firebase integration](#6-firebase-integration)
      - [6.1 Firebase performance example](#61-firebase-performance-example)

## 1. Basic Commands
- `flutter analyze` - linting
- `flutter run` - start app
- `flutter format .` - format all files in current directory
- `flutter pub global run devtools` (or `devtools`) - open dev tools
- `flutter packages pub run build_runner build --delete-conflicting-outputs` - run build_runner to generate `*.g.dart` files (replace `build` with `watch` to build files in watch mode)
- `flutter drive --target=test_driver/app.dart` - run e2e tests with flutter driver (optionally add `--no-build` flag to not rebuild source code if only tests changed)


## 2. How to BloC with Provider

#### 2.1. Create BloC class
```dart
class ExampleBloc extends ChangeNotifier {
  List<String> _texts = [];
  List<String> get texts => _texts;

  void addText(String text) {
    _texts.add(text);
    notifyListeners();
  }

  void clear() {
    _texts.clear();
    notifyListeners();
  }
}
```
   - It's important to call `notifyListeners` method after every action. This will notify every listeners that listens to our `ChangeNotifier` object which extends our BloC class.

#### 2.2. Provide BloC object down the tree:
```dart
ChangeNotifierProvider<ExampleBloc>(
  child: MaterialApp(
    title: 'MyTitle',
    home: HomeScreen(),
  ),
  // Here we are creating our BloC object
  create: (BuildContext context) => ExampleBloc(),
);
```

#### 2.3. Get access to BloC object from widgets placed down the tree
```dart
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ExampleBloc bloc = Provider.of<ExampleBloc>(context);
    return Container(
      // implementation...
    );
  }
}
```
To reload only specific part of tree use `Consumer` widget instead of `Provider.of`

```dart
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExampleBloc>(
      // Only widgets returned from this builder method
      // will be updated when bloc objects will be modified
      builder: (
        BuildContext context,
        ExampleBloc value,
        Widget child,
      ) {
        return Container(child: child);
      },
      // This part of tree will remain unchanged
      child: Container(),
    );
  }
}
```
You can also use `Selector` widget to ignore changes if they don't have an impact on the widget tree.

```dart
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // <(BloC Type), (The type of value we are looking for changes)>
    return Selector<ExampleBloc, int>(
      child: Container(),
      // value argument is our value returned from selector method 
      builder: (BuildContext context, int value, Widget child) {
        return Container();
      },
      // The constructor method will be called whenever the value
      // returned from the selection method is changed
      selector: (BuildContext context, ExampleBloc bloc) => bloc.texts.length,
    );
  }
}
```
#### 2.4. **That's all**. Use methods on on your BloC objects and all will be updated!


## 3. Project analysis options
- [camel_case_types](https://dart-lang.github.io/linter/lints/camel_case_types.html)
- [library_names](https://dart-lang.github.io/linter/lints/library_names.html)
- [file_names](https://dart-lang.github.io/linter/lints/file_names.html)
- [library_prefixes](https://dart-lang.github.io/linter/lints/library_prefixes.html)
- [non_constant_identifier_names](https://dart-lang.github.io/linter/lints/non_constant_identifier_names.html)
- [lines_longer_than_80_chars](https://dart-lang.github.io/linter/lints/lines_longer_than_80_chars.html)
- [slash_for_doc_comments](https://dart-lang.github.io/linter/lints/slash_for_doc_comments.html)  
- [prefer_adjacent_string_concatenation](https://dart-lang.github.io/linter/lints/prefer_adjacent_string_concatenation.html)
- [prefer_interpolation_to_compose_strings](https://dart-lang.github.io/linter/lints/prefer_interpolation_to_compose_strings.html)
- [prefer_function_declarations_over_variables](https://dart-lang.github.io/linter/lints/prefer_function_declarations_over_variables.html)
- [unnecessary_lambdas](https://dart-lang.github.io/linter/lints/unnecessary_lambdas.html)
- [prefer_equal_for_default_values](https://dart-lang.github.io/linter/lints/prefer_equal_for_default_values.html)
- [avoid_init_to_null](https://dart-lang.github.io/linter/lints/avoid_init_to_null.html)
- [unnecessary_getters_setters](https://dart-lang.github.io/linter/lints/unnecessary_getters_setters.html)
- [prefer_initializing_formals](https://dart-lang.github.io/linter/lints/prefer_initializing_formals.html)
- [type_init_formals](https://dart-lang.github.io/linter/lints/type_init_formals.html)
- [empty_constructor_bodies](https://dart-lang.github.io/linter/lints/empty_constructor_bodies.html)
- [unnecessary_new](https://dart-lang.github.io/linter/lints/unnecessary_new.html)
- [use_rethrow_when_possible](https://dart-lang.github.io/linter/lints/use_rethrow_when_possible.html)
- [use_to_and_as_if_applicable](https://dart-lang.github.io/linter/lints/use_to_and_as_if_applicable.html)
- [prefer_final_fields](https://dart-lang.github.io/linter/lints/prefer_final_fields.html)
- [use_setters_to_change_properties](https://dart-lang.github.io/linter/lints/use_setters_to_change_properties.html)
- [avoid_returning_this](https://dart-lang.github.io/linter/lints/avoid_returning_this.html)
- [avoid_positional_boolean_parameters](https://dart-lang.github.io/linter/lints/avoid_positional_boolean_parameters.html)
- [hash_and_equals](https://dart-lang.github.io/linter/lints/hash_and_equals.html)
- [avoid_null_checks_in_equality_operators](https://dart-lang.github.io/linter/lints/avoid_null_checks_in_equality_operators.html)
- [unnecessary_null_aware_assignments](https://dart-lang.github.io/linter/lints/unnecessary_null_aware_assignments.html)
- [unnecessary_null_in_if_null_operators](https://dart-lang.github.io/linter/lints/unnecessary_null_in_if_null_operators.html)
- [unnecessary_overrides](https://dart-lang.github.io/linter/lints/unnecessary_overrides.html)
- [unnecessary_parenthesis](https://dart-lang.github.io/linter/lints/unnecessary_parenthesis.html)
- [unnecessary_statements](https://dart-lang.github.io/linter/lints/unnecessary_statements.html)

## 4. Json serialization

#### 4.1. To create JSON serialize create model file like:
```dart
import 'package:json_annotation/json_annotation.dart';

/// You need to add `part` file import in way descripted below:
/// ```
/// part '<your_file_name>.g.dart'
/// ```
///
/// It's like importing your file current file but with `.g` before
/// your `.dart` extension.
part 'example_photo_model.g.dart';

/// Json serialization config
/// more about: 
/// `https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonSerializable-class.html`
@JsonSerializable(nullable: false, checked: true)
class ExamplePhotoModel {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  /// Map from json `download_url` field to property `downloadUrl`
  @JsonKey(name: 'download_url')
  final String downloadUrl;

  ExamplePhotoModel({this.id, this.author, this.width, this.height, this.url});

  /// Just simply copy paste the following lines to your model
  /// and replace `ExamplePhotoModel` with your model class
  factory ExamplePhotoModel.fromJson(Map<String, dynamic> json) =>
      _$ExamplePhotoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExamplePhotoModelToJson(this);
}
```

#### 4.2. Run `flutter pub run build_runner build`

#### 4.3. Thats all. To parse json:
```dart
ExamplePhotoModel photo = ExamplePhotoModel.fromJson(decodedJson);
```

## 5. Api
This starter app uses a simple wrapper around dart `http` client library that adds the
possibility to handle middlewares by `ApiLink`s (strongly inspired by apollo graphQL
client links) and use `Query` widget to make API calls right from the widgets tree [[MORE](https://pub.dev/packages/restui)].

## 6. Firebase integration
1. Create your firebase app [CLICK HERE](https://console.firebase.google.com/)
2. Configure project [CLICK HERE](https://codelabs.developers.google.com/codelabs/flutter-firebase/#5)
3. Add `google-service.json` and `GoogleService-Info.plist` files to your project.
- It is important to have the same app identifiers for both, firebase and flutter app: `com.example.myapp`

#### 6.1 Firebase performance example
You can measure your app performance in specific 
```dart
final Trace myTrace = FirebasePerformance.instance.newTrace("test_trace");
myTrace.start();

final Item item = cache.fetch("item");
if (item != null) {
  myTrace.incrementMetric("item_cache_hit", 1);
} else {
  myTrace.incrementMetric("item_cache_miss", 1);
}

myTrace.stop();
```
