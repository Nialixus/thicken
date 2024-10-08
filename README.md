<p align="center">
  <img src="https://github.com/Nialixus/thicken/blob/38cfe510ce50ec40b4dd2ed7fada365bf16f89d0/logo.png" alt="Thicken Logo" width="150">
</p>

# Thicken

<a href='https://pub.dev/packages/thicken'><img src='https://img.shields.io/pub/v/thicken.svg?logo=flutter&color=blue&style=flat-square'/></a>
<a href="https://codecov.io/gh/Nialixus/thicken"><img src="https://codecov.io/gh/Nialixus/thicken/graph/badge.svg?token=T66X1R33QE"/></a>
<a href="https://github.com/Nialixus/thicken/actions"><img src="https://github.com/Nialixus/thicken/actions/workflows/test_coverage.yaml/badge.svg" alt="test"/></a>
\
\
A widget that creates a thick visual effect by stacking multiple layers of a given `child` widget with slight translations based on the `thickness` value.

## Preview
<img src="https://github.com/user-attachments/assets/c663a3fe-1410-47d0-a802-2b085b7cf551" alt="Thicken Preview" width="1280">


## Install

Add this line to your pubspec.yaml.

```yaml
dependencies:
  thicken: ^1.0.0
```

## Usage

First, import the typewriter package.

```dart
import 'package:thicken/thicken.dart';
```

And use it like this

```dart
Thicken(
  thickness: 0.15,
  child: Icon(
    Icons.star,
    size: 50.0,
  ),
);
```

## Documentation

### TypeWriter.text

| Property           | Purpose                                                                                                           |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| thickness          | The amount of thickness applied. _**(It is not recommended to set thickness greater than 1.0)**_                  |
| child              | The child widget that will be thickened as multiple layers.                                                       |

## Example

- <a href="https://github.com/Nialixus/thicken/blob/master/example/lib/main.dart">thicken/example/lib/main.dart</a>
