import 'package:carelink/viewmodels/webrtc_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:carelink/di.dart';
import 'package:go_router/go_router.dart'; // 뒤로가기 위해 GoRouter 사용

class ListeningPage extends StatelessWidget {
  const ListeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<WebRTCViewModel>()..initialize(),
      child: Consumer<WebRTCViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('부모 - 듣기 모드'),

            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: RTCVideoView(
                      viewModel.remoteRenderer,
                      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // WebRTC 소리 듣기 시작
                        await viewModel.initialize();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('소리를 듣기 시작했습니다.')),
                        );
                      },
                      child: const Text('소리 시작'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // WebRTC 소리 중단
                        viewModel.stopAudio(); // 중단 기능 구현
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('소리 전송을 중단했습니다.')),
                        );
                      },
                      child: const Text('소리 중단'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // 부모의 홈페이지로 이동
                    context.go('/parent-home');
                  },
                  child: const Text('부모 홈페이지로 돌아가기'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
