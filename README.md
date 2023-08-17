# flutter_easy

### Theme

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
