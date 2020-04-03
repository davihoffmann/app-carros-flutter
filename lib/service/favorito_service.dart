import 'package:carros/models/carro.dart';
import 'package:carros/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritoService {
  
  // Para salvar a collection dentro do usuario logado
  CollectionReference get _users => Firestore.instance.collection('users');
  CollectionReference get _carros => _users.document(firebaseUserUid).collection('carros');

  // Para salvar apenas com a collection de carros
  //CollectionReference get _carros => Firestore.instance.collection('carros');

  Stream<QuerySnapshot> get stream => _carros.snapshots();

  Future<bool> favoritar(Carro carro) async {
    
    DocumentReference docRef = _carros.document("${carro.id}");
    DocumentSnapshot doc = await docRef.get();
    final exists = doc.exists;
    if(exists) {
      // deleta dos favoritos
      docRef.delete();

      return false;
    } else {
      //adiciona nos favoritos
      docRef.setData(carro.toMap());
      
      return true;
    }
  }

  Future<bool> isFavorito(Carro carro) async {
    DocumentReference docRef = _carros.document("${carro.id}");
    DocumentSnapshot doc = await docRef.get();
    final exists = doc.exists;

    return exists;
  }

  /*
  Future<bool> deleteCarros() async {
    print("Delete carros do usuário logado: $firebaseUserUid");

    final query = await _carros.getDocuments();
    for(DocumentSnapshot doc in query.documents) {
      await doc.reference.delete();
    }

    _users.document(firebaseUserUid).delete();
  }
  */

}