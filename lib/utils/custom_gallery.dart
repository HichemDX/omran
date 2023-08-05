import 'dart:io';

import 'package:bnaa/models/image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:get/get.dart';

class Gallery extends StatefulWidget {
  List? listImages;
  int? index;
  Function(int)? deletedImage;

  Gallery({Key? key, this.listImages, this.index, this.deletedImage})
      : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  int? indexOfImage;

  @override
  void initState() {
    indexOfImage = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return widget.listImages![index] is File
                      ? PhotoViewGalleryPageOptions(
                          imageProvider: FileImage(widget.listImages![index]),
                          initialScale: PhotoViewComputedScale.contained * 1,
                        )
                      : PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(
                              (widget.listImages![index] as ProductImage).link),
                          initialScale: PhotoViewComputedScale.contained * 1,
                        );
                },
                itemCount: widget.listImages!.length,
                onPageChanged: (val) {
                  indexOfImage = val;
                },
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                      strokeWidth: 2,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                ),
                // backgroundDecoration: widget.backgroundDecoration,
                pageController: PageController(initialPage: widget.index!),
                // onPageChanged: onPageChanged,
              ),
            ),
            if (widget.deletedImage != null)
              Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    widget.deletedImage!(indexOfImage!);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Remove'.tr,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              )
          ],
        ));
  }
}
