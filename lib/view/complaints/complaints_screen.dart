import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/resources/Components/complaint_card.dart';
import 'package:sports_application/view/complaints/hold_complaints.dart';
import 'package:sports_application/view/complaints/new_complaints.dart';
import 'package:sports_application/view/complaints/updated_complaints.dart';
import 'package:sports_application/view_model/complaints_provider.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(
            text: 'New',
          ),
          Tab(
            text: 'Hold',
          ),
          Tab(
            text: 'Updated',
          ),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
        NewComplaints(),
        HoldComplaints(),
        UpdatedComplaints()
        
      ])
    );
  }
}
