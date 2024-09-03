// import 'dart:io';

// import 'package:science_platform/src/core/page_state/state.dart';
// import 'package:science_platform/src/utils/extensions/generic_extension.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';

// class PDFController extends GetxController {
//   /// Page State
//   final Rx<PageState> _pageStateController = Rx(PageState.loading);

//   get pageState => _pageStateController.value;

//   bool get isLoading => pageState == PageState.loading;

//   File? pdf;

//   Future<void> savePDF(
//     PdfDocumentLoadedDetails details,
//     String documentName,
//   ) async {
//     final Directory tempPath = await getApplicationDocumentsDirectory();
//     String path = '${tempPath.path}/$documentName.pdf';
//     File tempFile = File(path);
//     if (await tempFile.exists()) {
//       pdf = tempFile;
//     } else {
//       List<int> bytes = await details.document.save();
//       pdf = await tempFile.writeAsBytes(bytes);
//     }
//     if (pdf.isNotNull) _pageStateController(PageState.success);
//   }
// }
