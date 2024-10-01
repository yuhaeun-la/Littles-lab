import 'package:carelink/viewmodels/parents_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carelink/di.dart';
import 'package:go_router/go_router.dart';

class ParentSetupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ParentViewModel>(),
      child: Consumer<ParentViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: Text('부모 설정')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: viewModel.nameController,
                    decoration: InputDecoration(labelText: '아이 이름'),
                  ),
                  TextField(
                    controller: viewModel.ageController,
                    decoration: InputDecoration(labelText: '아이 나이'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  viewModel.imageFile == null
                      ? Text('이미지를 선택해주세요')
                      : Image.file(viewModel.imageFile!, height: 100),
                  ElevatedButton(
                    onPressed: viewModel.pickImage,
                    child: Text('갤러리에서 이미지 선택'),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await viewModel.uploadData();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('등록 완료!'))
                        );
                        context.go('/webrtc/true'); // WebRTC 페이지로 이동
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    child: Text('등록하기'),
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
