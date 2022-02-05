import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataController extends GetxController{

  Future searchData(String controller) async {
    return await FirebaseFirestore.instance.collection('note').where('caseTitle', arrayContains: controller).get();
  }

}