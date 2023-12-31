# flutter_easy

## Theme

#### TextStyle extension
```dart
Text("content", style: TextStyle().black.w400.s16);
```

#### ThemeExtensions
Import custom config to easy packages.

```dart
ThemeData(
  extensions: const [
    EasyTheme(
      primary: Color(0xFF3C5BFF),
      destructive: Color(0xFFFF3E33),
      ),
  ],
)
```
## Foundation

#### EasyError

a simple error struct

```dart
abstract class EasyError {
  final int ec;
  final String em;
  final String dm;

  const EasyError(this.ec, this.em, this.dm);
}
```

#### EasyErrorMixin

provide `handleError(dynamic error)`, will throw a `EasyError`

```dart
fetchData().then().catchError(handleError);
```

#### log

print log when debug.

```dart
debug('debug message');
verbose('verbose message');
info('info message');
warning('warning message');
error('error message');
```

#### RegularExpression

some custom regular expression, such as `email`, `phone`, `name`, `website`, `uppercase`, `lowercase`, `specialCharacters`, `macaddress`, `numberic`.

```dart
RegularExpression.email.regExp.hasMatch(str);
```

#### Status

some status based on `EasyStatus`, usally used for request reset api and show different status.

```dart
enum EasyStatus { idle, loading, process, success, failure }
```
Usage - `Status.failure` is based on `EasyError`.

```dart
const Status.loading();
const Status.success();
const Status.failure(error: EasyError.timeout);
```

#### Interface

`Clearable` provider a `clear()` method.

`Disposable` provider a `dispose()` method.

## Components

#### EasyBackButton

`EasyBackButton` is a leading back button on navigatorBar. It will pop automatic when pressed (don't manual call `Navigator.of(context).pop` in `onPressed`).

* `EasyBackButton()` default back button, show a back arrow
* `EasyBackButton.close()` show a close icon
* `EasyBackButton.cancel()` show `Cancel` text
* `EasyBackButton.text()` custom text such as `Cancel`
* `previousTitle` optional, means previous page title
* `backIcon` can set a icon or text, default is a back arrow
* `color` was used for backIcon and text style, defult `black87`

```dart
EasyBackButton();
EasyBackButton(
	backIcon: Icon(Icons.back), 
	previousTitle: 'Settings', 
	onPressed: () {
		// other operation
	},
);
EasyBackButton.close();
EasyBackButton.cancel();
EasyBackButton.text('Cancel');
```

#### ModalAppBar

`ModalAppBar` is a custom app bar, only used for modal page route `showModalRoute`.

#### Dialog

* `DialogPage`
* `DialogColumnView`
* `DialogComplexView`
* `DialogMessageView`
* `DialogOption`
* `DialogData`
* `BottomSheetView`

#### TextFiled

* `EasyTextField`
* `EditTextField`
* `NumCharTextField`
* `SearchTextField`
* `UnderlinedTextField`

#### Toast

* `ImageToast`
* `LoadingToast`
* `TextToast`
