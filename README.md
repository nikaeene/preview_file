<!--
This Package try to preview the files in Flutter.
It supports the following files:
- Images
- PDF
Other kind of files will be supported in the future.
-->


Package will return a widget that will preview the file. This will makes it easier to preview the files in Flutter.
You need to pass the file path and the width you need to the widget and it will return the preview of the file.

## Features

If you want to preview a file from url, you can use:
```dart
Container(
child: FilePreview(
//filePath: uploadModel.imageFile!.path,
fileUrl: 'https://www.ledzeppelin.com/sites/g/files//g2000013721/files/sites/default/files/201702/1968_001.jpg',
width: 200,
).preview(),
);
```
If you have the file in the device, you can pass the file path to the widget.


## Getting started

Add the package to your pubspec.yaml file:

```yaml
dependencies:
  file_preview: ^0.0.1
```
## Usage

You can just pass the file path and the width you need to the widget and it will return the preview of the file.

```dart
Container(
child: FilePreview(
filePath: file.path,
width: 100,
).preview(),
);
```

## Additional information

This package is still in development and will be updated with more features in the future. If you have any suggestions or issues, please create an issue in the repository.
