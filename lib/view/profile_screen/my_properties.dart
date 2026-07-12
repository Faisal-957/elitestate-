import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:elitestate/core/widgets/propertycard.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: golden),
        title: Text("My Properties", style: style16.copyWith(color: golden)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('properties')
            .where('ownerId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: golden),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No Properties Found",
                style: style16.copyWith(color: whiteColor),
              ),
            );
          }

          final properties = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final doc = properties[index];
              final data = doc.data() as Map<String, dynamic>;

              return PropertyCard(
                property: PropertyModel.fromMap(data, docId: doc.id),
              );
            },
          );
        },
      ),
    );
  }
}
