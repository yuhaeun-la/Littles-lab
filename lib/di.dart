import 'package:carelink/viewmodels/child_viewmodel.dart';
import 'package:carelink/viewmodels/parents_viewmodel.dart';
import 'package:carelink/viewmodels/webrtc_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Firebase 인스턴스 등록
  getIt.registerLazySingleton(() => FirebaseStorage.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  // ViewModel 등록
  getIt.registerFactory(() => ParentViewModel());
  getIt.registerFactory(() => ChildViewModel());
  getIt.registerFactory(() => WebRTCViewModel());
}
