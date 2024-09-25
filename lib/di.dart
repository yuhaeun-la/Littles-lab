// di.dart
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'viewmodels/parent_view_model.dart';
import 'viewmodels/child_view_model.dart';
import 'viewmodels/webrtc_view_model.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Firebase 인스턴스 등록
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseStorage.instance);

  // ViewModel 등록
  getIt.registerFactory(() => ParentViewModel());
  getIt.registerFactory(() => ChildViewModel());
  getIt.registerFactory(() => WebRTCViewModel());
}
