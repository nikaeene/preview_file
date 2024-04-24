import 'package:flutter/cupertino.dart';

import 'package:preview_file/preview_file.dart';

void main() {
  Container(
    child: FilePreview(
//filePath: uploadModel.imageFile!.path,
      fileUrl:
          'https://www.ledzeppelin.com/sites/g/files//g2000013721/files/sites/default/files/201702/1968_001.jpg',
      width: 200,
    ).preview(),
  );
}
