import 'package:carelink/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:carelink/viewmodels/child_viewmodel.dart';
import 'package:go_router/go_router.dart';


class ChildSetupPage extends StatelessWidget {
  const ChildSetupPage({super.key});

  Future<void> _setUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', role); // 아이 역할 저장
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ChildViewModel>(),
      child: Consumer<ChildViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('아이 설정')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: viewModel.codeController,
                    decoration: const InputDecoration(labelText: '부모 코드 입력'),
                  ),
                  const SizedBox(height: 10),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await viewModel.validateCode();
                        await _setUserRole('child'); // 아이 역할 저장
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('페어링 성공!')),
                        );
                        context.go('/child-home'); // 아이 홈 페이지로 이동
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    child: const Text('코드 확인하기'),
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
