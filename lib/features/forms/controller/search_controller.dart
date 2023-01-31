import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_tree/features/member/models/member_model.dart';
import 'package:flutter/cupertino.dart';

class SearchController extends ChangeNotifier {
  
  final fireDb = FirebaseFirestore.instance.collection('members');
  final searchController = TextEditingController();
  
  final List<Member> memberList = [];

  updtadeList(){
    notifyListeners();
  }
  addSpouses(List<Member> spouses){
    memberList.clear();
    memberList.addAll(spouses);
  }

  Future<List<Member>> searchMember()async{
    final data =await fireDb
        .where("searchCase", arrayContains : searchController.text.toLowerCase())
        .get();
    final list = data.docs.map((e) {
   
      return Member.fromJson(e.data());
    }); 
    memberList.clear();
    memberList.addAll(list);
    updtadeList(); 
    return memberList;   
  }
}