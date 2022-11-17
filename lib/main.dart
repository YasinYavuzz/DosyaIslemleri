import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DosyaIslemleri(),
    );
  }
}

class DosyaIslemleri extends StatefulWidget {
  const DosyaIslemleri({super.key});

  @override
  State<DosyaIslemleri> createState() => _DosyaIslemleriState();
}

class _DosyaIslemleriState extends State<DosyaIslemleri> {
  String _filePath = "";

  Future<String> get _localDevicePath async {
    final _devicePath = await getApplicationDocumentsDirectory();
    return _devicePath.path;
  }

  Future<File> _localFile({String? path, String? type}) async {
    String _path = await _localDevicePath;

    var _newPath = await Directory("$_path/$path").create();
    return File("${_newPath.path}/hwa.$type");
  }

  Future _downloadSamplePDF() async {
    final _response = await http
        .get(Uri.parse("http://www.africau.edu/images/default/sample.pdf"));
    if (_response.statusCode == 200) {
      final _file = await _localFile(path: "veli", type: "pdf");
      final _saveFile = await _file.writeAsBytes(_response.bodyBytes);
      //Logger().i("File write complete. File Path ${_saveFile.path}");
      setState(() {
        _filePath = _saveFile.path;
      });
    } else {
      //Logger().e(_response.statusCode);
    }
  }

  Future _downloadSampleVideo() async {
    final _response = await http.get(Uri.parse(
        "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"));
    if (_response.statusCode == 200) {
      final _file = await _localFile(type: "mp4", path: "videos");
      final _saveFile = await _file.writeAsBytes(_response.bodyBytes);
      //Logger().i("File write complete. File Path ${_saveFile.path}");
      setState(() {
        _filePath = _saveFile.path;
      });
    } else {
      //Logger().e(_response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.file_download),
              label: Text("Sample Pdf"),
              onPressed: () {
                _downloadSamplePDF();
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.file_download),
              label: Text("Sample Videos"),
              onPressed: () {
                _downloadSampleVideo();
              },
            ),
            Text(_filePath),
            ElevatedButton.icon(
              icon: Icon(Icons.shop_two),
              label: Text("Show"),
              onPressed: () async {
                final _openFile = await OpenFile.open(_filePath, type: "video/mp4");
              },
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// class FileDownloadView extends StatefulWidget {
//   @override
//   _FileDownloadViewState createState() => _FileDownloadViewState();
// }

// class _FileDownloadViewState extends State<FileDownloadView> {
//   String _filePath = "";

//   Future<String> get _localDevicePath async {
//     final _devicePath = await getApplicationDocumentsDirectory();
//     return _devicePath.path;
//   }

//   Future<File> _localFile({String? path, String? type}) async {
//     String _path = await _localDevicePath;

//     var _newPath = await Directory("$_path/$path").create();
//     return File("${_newPath.path}/hwa.$type");
//   }

//   Future _downloadSamplePDF() async {
//     final _response =
//         await http.get(Uri.parse("http://www.africau.edu/images/default/sample.pdf"));
//     if (_response.statusCode == 200) {
//       final _file = await _localFile(path: "veli", type: "pdf");
//       final _saveFile = await _file.writeAsBytes(_response.bodyBytes);
//       //Logger().i("File write complete. File Path ${_saveFile.path}");
//       setState(() {
//         _filePath = _saveFile.path;
//       });
//     } else {
//       //Logger().e(_response.statusCode);
//     }
//   }

//   Future _downloadSampleVideo() async {
//     final _response = await http.get(Uri.parse("https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4"));
//     if (_response.statusCode == 200) {
//       final _file = await _localFile(type: "mp4", path: "videos");
//       final _saveFile = await _file.writeAsBytes(_response.bodyBytes);
//       //Logger().i("File write complete. File Path ${_saveFile.path}");
//       setState(() {
//         _filePath = _saveFile.path;
//       });
//     } else {
//       //Logger().e(_response.statusCode);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton.icon(
//               icon: Icon(Icons.file_download),
//               label: Text("Sample Pdf"),
//               onPressed: () {
//                 _downloadSamplePDF();
//               },
//             ),
//             ElevatedButton.icon(
//               icon: Icon(Icons.file_download),
//               label: Text("Sample Videos"),
//               onPressed: () {
//                 _downloadSampleVideo();
//               },
//             ),
//             Text(_filePath),
//             ElevatedButton.icon(
//               icon: Icon(Icons.shop_two),
//               label: Text("Show"),
//               onPressed: () async {
//                 final _openFile = await OpenFile.open(_filePath);
                
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
