import 'package:carelink/viewmodels/child_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:carelink/di.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ChildSetupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ChildViewModel>(),
      child: Consumer<ChildViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: Text('아이 설정')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: viewModel.codeController,
                    decoration: InputDecoration(labelText: '부모 코드 입력'),
                  ),
                  SizedBox(height: 10),

                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await viewModel.validateCode();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('페어링 성공!')),
                        );
                        context.go('/webrtc/false'); // WebRTC 페이지로 이동
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    child: Text('코드 확인하기'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
