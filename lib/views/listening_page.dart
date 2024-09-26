// views/webrtc_page.dart
import 'package:carelink/di.dart';
import 'package:carelink/viewmodels/webrtc_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCPage extends StatelessWidget {
  final bool isParent;

  WebRTCPage({required this.isParent});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<WebRTCViewModel>()..initialize(),
      child: Consumer<WebRTCViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: Text(isParent ? '부모 - 듣기 모드' : '아이 - 전송 모드')),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: RTCVideoView(
                      isParent ? viewModel.remoteRenderer : viewModel.localRenderer,
                      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (isParent) {
                      await viewModel.initialize();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('WebRTC 연결 시작됨 - 소리를 듣기 시작했습니다.')),
                      );
                    } else {
                      await viewModel.initialize();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('WebRTC 연결 시작됨 - 소리 전송을 시작했습니다.')),
                      );
                    }
                  },
                  child: Text(isParent ? '듣기 시작' : '전송 시작'),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
