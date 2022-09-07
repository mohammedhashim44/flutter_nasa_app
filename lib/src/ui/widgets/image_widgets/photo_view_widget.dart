import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewWidget extends StatefulWidget {
  final String url;

  const PhotoViewWidget({Key? key, required this.url}) : super(key: key);

  @override
  State<PhotoViewWidget> createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {
  bool _isDownloading = false;
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String? imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(
              widget.url,
            ),
            loadingBuilder: (c, e) {
              if (e == null) {
                return const Center();
              }
              return Center(
                child: CircularProgressIndicator(
                  value: e.expectedTotalBytes != null
                      ? e.cumulativeBytesLoaded / e.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          Positioned(
            top: 20,
            left: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      onDownloadClicked(context);
                    },
                    child: Row(
                      children: const [
                        Text("Download Image"),
                        Icon(Icons.download),
                      ],
                    ),
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  ),
                  const SizedBox(width: 10),
                  if (_isDownloading)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: _buildProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Text(_progress.toString() + "%");
  }

  void onDownloadClicked(BuildContext context) async {
    setState(() {
      _isDownloading = true;
    });
    var imageId = await ImageDownloader.downloadImage(widget.url);

    if (imageId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error Downloading"),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Image Downloaded"),
        backgroundColor: Colors.green,
      ));
    }
    setState(() {
      _isDownloading = false;
    });
  }
}
