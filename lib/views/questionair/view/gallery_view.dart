import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/views/questionair/viewmodel/gallery_view_model.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_check_box.dart';
import 'package:mhealth/widgets/image_view_widget.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tuple/tuple.dart';

class GalleryView extends StatefulWidget {
  final String title;
  final List<AttachmentModel> attachmentList;
  final Function(String) onRemoveClick;
  const GalleryView({super.key, required this.title, required this.attachmentList, required this.onRemoveClick});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  late GalleryViewModel galleryViewModel;

  viewImage(List<int> data) {
    showDialog(
      barrierDismissible: true,
      context: context,
      useSafeArea: true,
      builder: (_) {
        return ImageViewWidget(
          imageList: data,
        );
      },
    );
  }

  void removeImage(String fileName) async {
    bool delete = await confirmDelete();
    if (delete) {
      widget.onRemoveClick(fileName);
      galleryViewModel.removeImage(fileName);
      if (galleryViewModel.attachmentList.isEmpty) {
        if (mounted) {
          Navigator.pop(context);
        }
      }
    }
  }

  Future<bool> confirmDelete() async {
    bool? result = await CommonFunctions.openDialog<bool?>(
      context: context,
      buttonCancelText: "No",
      buttonText: "Yes",
      title: "Confirm?",
      subtitle: "Are you sure want to delete image",
      action: (context) {
        Navigator.of(context).pop(true);
      },
      onCancelAction: (context) {
        Navigator.pop(context, false);
      },
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GalleryViewModel(widget.attachmentList),
        builder: (context, _) {
          galleryViewModel = Provider.of<GalleryViewModel>(context, listen: false);
          return Scaffold(
            appBar: CustomAppBar(
              appBarTitleType: CustomAppBarTitleType.TEXT,
              titleText: widget.title,
              onLeadingClick: () {
                Navigator.pop(context);
              },
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Selector<GalleryViewModel, Tuple2<int, List<AttachmentModel>>>(
                selector: (p0, p1) => Tuple2(p1.attachmentList.length, p1.attachmentList),
                builder: (context, _, child) {
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: List.generate(widget.attachmentList.length, (index) {
                      var attachmentData = widget.attachmentList[index];
                      Future<List<int>>? future = CommonFunctions().readFileInIsolate(attachmentData.filePath);
                      return FutureBuilder(
                        future: future,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Skeletonizer(
                                enabled: true,
                                ignoreContainers: false,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            default:
                              if (snapshot.hasError) {
                                return const Icon(Icons.error);
                              }
                              if (snapshot.hasData) {
                                List<int>? data = snapshot.data;
                                return data == null
                                    ? const Icon(Icons.error)
                                    : Stack(
                                        children: [
                                          Positioned.fill(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: InkWell(
                                                onTap: () {
                                                  viewImage(data);
                                                },
                                                child: Image.memory(
                                                  Uint8List.fromList(data),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 5,
                                            top: 5,
                                            child: InkWell(
                                              onTap: () {
                                                removeImage(attachmentData.fileName);
                                              },
                                              child: const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: AppColorScheme.kPrimaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                              }
                              return const Icon(Icons.error);
                          }
                        },
                      );
                    }),
                  );
                },
              ),
            ),
          );
        });
  }
}
