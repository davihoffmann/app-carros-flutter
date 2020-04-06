import 'dart:io';

import 'package:carros/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart' as path;

import 'api_response.dart';

String firebaseUserUid;

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse> loginGoogle() async {
    try {
      // Login com o Google
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Google User: ${googleUser.email}");

      // Credenciais para o Firebase
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login no Firebase
      AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser fUser = result.user;
      print("Firebase Nome: ${fUser.displayName}");
      print("Firebase Email: ${fUser.email}");
      print("Firebase Foto: ${fUser.photoUrl}");

      print(fUser.uid);

      // Cria um usuario do app
      final user = Usuario(
        id: fUser.uid,
        nome: fUser.displayName,
        login: fUser.email,
        email: fUser.email,
        urlFoto: fUser.photoUrl,
      );
      user.save();

      saveUser(user);

      // Resposta genérica
      //return ApiResponse.ok(result: user);
      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error $error");
      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }

  Future<ApiResponse> login(String email, String senha) async {
    try {
      // Login no Firebase
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: senha);
      final FirebaseUser fUser = result.user;
      print("Firebase Nome: ${fUser.displayName}");
      print("Firebase Email: ${fUser.email}");
      print("Firebase Foto: ${fUser.photoUrl}");

      // Cria um usuario do app
      final user = Usuario(
        id: fUser.uid,
        nome: fUser.displayName,
        login: fUser.email,
        email: fUser.email,
        urlFoto: fUser.photoUrl,
      );
      user.save();

      saveUser(user);

      // Resposta genérica
      //return ApiResponse.ok(result: user);
      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error $error");
      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }

  Future<void> logout() async {
    //await FavoritoService().deleteCarros();

    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<ApiResponse> cadastrar(String nome, String email, String senha, {File file}) async {
    try {
      // Cria usuario do Firebase
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      final FirebaseUser fUser = result.user;
      print("Firebase Nome: ${fUser.displayName}");
      print("Firebase Email: ${fUser.email}");
      print("Firebase Foto: ${fUser.photoUrl}");

      // Dados para atualizar o usuario
      final userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nome;
      userUpdateInfo.photoUrl = "https://pngimage.net/wp-content/uploads/2018/05/default-user-image-png-7.png";

      if(file != null) {
        userUpdateInfo.photoUrl = await FirebaseService.uploadFirebaseStorage(file);
      }

      print("foto do usuario >>> ${userUpdateInfo.photoUrl}");

      // Cria um usuario do app
      final user = Usuario(
        id: fUser.uid,
        nome: userUpdateInfo.displayName,
        login: fUser.email,
        email: fUser.email,
        urlFoto: userUpdateInfo.photoUrl,
      );

      fUser.updateProfile(userUpdateInfo);
      user.save();

      return ApiResponse.ok(msg: "Usuário criado com sucesso!");
    } catch(error) {
      print(error);

      if(error is PlatformException) {
        print("Error Code ${error.code}");
        return ApiResponse.error(msg: "Erro ao criar um usuário.\n\n${error.message}");
      }

      return ApiResponse.error(msg: "Não foi possível criar um usuário");
    }
  }

  void saveUser(Usuario fUser) async {
    if(fUser != null) {
      firebaseUserUid = fUser.id;
      print(firebaseUserUid);
      DocumentReference refUser = Firestore.instance.collection("users").document(firebaseUserUid);

      refUser.setData({
        'nome': fUser.nome,
        'email': fUser.email,
        'login': fUser.email,
        'urlFoto': fUser.urlFoto
      });
    }
  }

  static Future<String> uploadFirebaseStorage(File file) async {
    print("Upload to Storage $file");
    String fileName = path.basename(file.path);
    final storageRef = FirebaseStorage.instance.ref().child(fileName);

    final StorageTaskSnapshot task = await storageRef.putFile(file).onComplete;
    final String urlFoto = await task.ref.getDownloadURL();
    print("Storage > $urlFoto");
    return urlFoto;
  }

}
