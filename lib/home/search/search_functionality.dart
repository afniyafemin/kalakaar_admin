import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kalakaar_admin/constants/color_constant.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = []; // This will hold the usernames

  CustomSearchDelegate() {
    _fetchUsernames();
  }

  Future<void> _fetchUsernames() async {
    // Fetch usernames from Firestore
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    searchTerms = snapshot.docs.map((doc) => doc['username'] as String).toList();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: ClrConstant.primaryColor),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back, color: ClrConstant.primaryColor),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = searchTerms
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return _buildSuggestionsOrResults(matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = searchTerms
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return _buildSuggestionsOrResults(matchQuery);
  }

  Widget _buildSuggestionsOrResults(List<String> matchQuery) {
    return Container(
      color: ClrConstant.whiteColor,
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
            onTap: () {
              // Handle the tap event, e.g., navigate to user profile
              close(context, result);
            },
          );
        },
      ),
    );
  }
}