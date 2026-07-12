import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitestate/core/constant/colors.dart';
import 'package:elitestate/core/constant/textstyle.dart';
import 'package:elitestate/core/widgets/propertycard.dart';
import 'package:elitestate/models/propertiey_cardmodel.dart';
import 'package:elitestate/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _selectedCategory = "All";

  final List<String> _categories = const [
    "All",
    "House",
    "Apartment",
    "Villa",
    "Office",
    "Land",
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AuthViewModel>().getUserData();
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: _buildCategoryChips()),
            SliverToBoxAdapter(child: _buildSectionTitle()),
            _buildPropertyList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Row(
        children: [
          Expanded(
            child: Consumer<AuthViewModel>(
              builder: (context, vm, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _greeting(),
                      style: style12.copyWith(
                        color: whiteColor.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      vm.userName.isNotEmpty ? vm.userName : "Guest",
                      style: style24.copyWith(color: whiteColor, fontSize: 22),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: lightBlack,
              shape: BoxShape.circle,
              border: Border.all(color: golden.withValues(alpha: 0.25)),
            ),
            child: Badge(
              backgroundColor: primaryColor,
              smallSize: 8,
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: golden,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: lightBlack,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: whiteColor),
                decoration: InputDecoration(
                  hintText: "Search by title or location...",
                  hintStyle: TextStyle(
                    color: whiteColor.withValues(alpha: 0.4),
                  ),
                  prefixIcon: const Icon(Icons.search, color: golden),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.close_rounded,
                            color: whiteColor.withValues(alpha: 0.5),
                          ),
                          onPressed: () => _searchController.clear(),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              gradient: primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: () {
                // Open filter screen or bottom sheet
              },
              icon: const Icon(Icons.tune_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
        itemCount: _categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (_) => setState(() => _selectedCategory = category),
            showCheckmark: false,
            labelStyle: TextStyle(
              color: isSelected
                  ? Colors.black
                  : whiteColor.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            backgroundColor: lightBlack,
            selectedColor: golden,
            side: BorderSide(
              color: isSelected ? golden : Colors.white.withValues(alpha: 0.08),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Featured Properties",
            style: style18.copyWith(
              color: golden,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('properties').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator(color: golden)),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState("No Properties Found");
        }

        final properties = snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final title = (data['title'] ?? "").toString().toLowerCase();
          final location = (data['location'] ?? "").toString().toLowerCase();

          final matchesSearch =
              _searchQuery.isEmpty ||
              title.contains(_searchQuery) ||
              location.contains(_searchQuery);

          final matchesCategory =
              _selectedCategory == "All" ||
              title.contains(_selectedCategory.toLowerCase());

          return matchesSearch && matchesCategory;
        }).toList();

        if (properties.isEmpty) {
          return _buildEmptyState("No Properties Match Your Search");
        }

        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final doc = properties[index];
              final data = doc.data() as Map<String, dynamic>;

              return PropertyCard(
                property: PropertyModel.fromMap(data, docId: doc.id),
              );
            }, childCount: properties.length),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.apartment_rounded,
              size: 48,
              color: whiteColor.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(color: whiteColor.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
