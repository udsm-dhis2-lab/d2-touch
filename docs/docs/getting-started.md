---
title: Getting Started
slug: /getting-started
---

:::caution

D2Touch is inspired by DHIS2 Android SDK. Some of the functionalities may not yet be available as the SDK.

:::
## Installation

<!--DHIS2-SECTION-ID:installation-->

Include dependency in pubspec.yaml.

```yml

dependencies:
    flutter:
        sdk: flutter
    dhis2_flutter_sdk: ^2.1.7
    ...

```

Include dev_dependency in pubspec.yaml.

```yml
dev_dependencies:
    flutter_test:
        sdk: flutter
    build_runner: ^2.1.7
    ...

```

Install Packages:

```shell

flutter pub get

```

Additionally, you need to run the build_runner to allow class reflection:

```shell

flutter packages pub run build_runner build --delete-conflicting-outputs

```

## D2Touch initialization

<!--TODO-->

<!--DHIS2-SECTION-ID:initialization-->

In order to start using the SDK, the first step is to initialize to a D2Touch instance as follows:

```dart
D2TouchInstance d2Touch = D2Touch.initialize(
        instance: "https://play.dhis2.org/2.36.10"
    );
```