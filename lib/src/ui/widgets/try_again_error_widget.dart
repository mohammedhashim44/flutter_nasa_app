import 'package:flutter/material.dart';

class TryAgainErrorWidget extends StatelessWidget {
  final Function onTryAgainClicked;
  const TryAgainErrorWidget({Key? key, required this.onTryAgainClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Error Happened"),
          ElevatedButton(
            onPressed: () {
              onTryAgainClicked.call();
            },
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }
}
