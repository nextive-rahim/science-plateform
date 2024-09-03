import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:science_platform/src/core/theme/colors.dart';
import 'package:science_platform/src/feature/courses/content/controller/contents_view_controller.dart';
import 'package:science_platform/src/utils/extensions/generic_extension.dart';
import 'package:science_platform/src/widgets/error_feedback.dart';
import 'package:science_platform/src/widgets/loading_indicator.dart';

// ignore: must_be_immutable
class PDFScreen extends GetView<ContentsViewController> {
  const PDFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            !controller.singleContentIsLoading
                ? controller.pdfContent?.title ?? ''
                : '',
          ),
        ),
      ),
      body: Obx(() {
        if (controller.singleContentIsLoading) {
          return _buildLoadingIndicator();
        }
        if (controller.pdfLink.isNotNull) {
          //TODO: Using rijon bhai's pdf code(slightly modified) for now. Will change later if i get enough time
          return PDFViewerWidget(
            pdfLink: controller.pdfLink!,
          );
        }

        return const GenericErrorFeedback();
      }),
    );
  }

  Widget _buildLoadingIndicator() => LoadingIndicator.list();
}

class PDFViewerWidget extends StatefulWidget {
  final String pdfLink;

  const PDFViewerWidget({
    super.key,
    required this.pdfLink,
  });

  @override
  _PDFViewerWidgetState createState() => _PDFViewerWidgetState();
}

class _PDFViewerWidgetState extends State<PDFViewerWidget> {
  String urlPDFPath = "";
  String title = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController? _pdfViewController;
  bool loaded = false;

  Future<File> getFileFromUrl(String url) async {
    String fileName = url.split('/').last;
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName");
      log("dir path ${dir.path}/$fileName");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  void requestPermission() async {
    await Permission.storage.request();
  }

  @override
  void initState() {
    requestPermission();

    getFileFromUrl(widget.pdfLink).then(
      (value) => {
        setState(() {
          if (value.isNotNull) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(urlPDFPath);
    if (loaded) {
      return Stack(
        children: [
          PDFView(
            filePath: urlPDFPath,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            fitPolicy: FitPolicy.BOTH,
            onError: (e) {
              //Show some error message or UI
            },
            onRender: (pages) {
              setState(() {
                _totalPages = pages!.toInt();
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              setState(() {
                _pdfViewController = vc;
              });
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                _currentPage = page!.toInt();
              });
            },
            onPageError: (page, e) {},
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildPageNavigation(),
          ),
        ],
      );
    } else {
      if (exists) {
        //Replace with your loading UI
        return const Center(
          child: Text(
            "Loading..",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      } else {
        //Replace Error UI
        return const Text(
          "PDF Not Available",
          style: TextStyle(fontSize: 20),
        );
      }
    }
  }

  Container _buildPageNavigation() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 41,
            width: 150,
            child: TextFormField(
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
              onChanged: (page) {
                if (int.parse(page) > 0) {
                  _pdfViewController!.setPage(int.parse(page));
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 10, right: 20, bottom: 10, left: 20),
                isDense: true,
                hintText: 'Page Number',
                hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black38),
                fillColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.lightBlack20,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.lightBlack20,
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                iconSize: 50,
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    if (_currentPage > 0) {
                      _currentPage--;
                      _pdfViewController!.setPage(_currentPage);
                    }
                  });
                },
              ),
              Text(
                "${_currentPage + 1}/$_totalPages",
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                iconSize: 50,
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    if (_currentPage < _totalPages - 1) {
                      _currentPage++;
                      _pdfViewController!.setPage(_currentPage);
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
