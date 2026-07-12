import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/widgets/custom_auth.dart';
import 'package:elitestate/core/widgets/propertycard.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:elitestate/view_model/property_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AuthViewModel>().getUserData();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: golden),
          onPressed: () {},
        ),
        title: Consumer<AuthViewModel>(
          builder: (context, vm, child) {
            return Text(
              "Welcome ${vm.userName}",
              style: const TextStyle(
                color: golden,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        actions: [
          Badge(
            child: IconButton(
              icon: const Icon(Icons.notifications, color: golden),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: TextEditingController(),
                      hintText: "Search...",
                      prefixIcon: Icons.search,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: golden,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Open filter screen or bottom sheet
                      },
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('properties')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Properties Found",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    final properties = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: properties.length,
                      itemBuilder: (context, index) {
                        final data = properties[index];

                        return PropertyCard(
                          property: PropertyModel(
                            id: data['id'],
                            title: data['title'],
                            location: data['location'],

                            price: (data['price'] as num).toDouble(),
                            bedrooms: data['bedrooms'],
                            bathrooms: data['bathrooms'],
                            area: (data['area'] as num).toDouble(),
                            isFavorite: data['isFavorite'],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
