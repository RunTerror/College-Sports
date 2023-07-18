import 'package:flutter/material.dart';
import 'package:sports_application/view/complaints/hold_complaints.dart';
import 'package:sports_application/view/complaints/new_complaints.dart';
import 'package:sports_application/view/complaints/updated_complaints.dart';

class AdminComplaintScreen extends StatefulWidget {
  const AdminComplaintScreen({super.key});

  @override
  State<AdminComplaintScreen> createState() => _AdminComplaintScreenState();
}

class _AdminComplaintScreenState extends State<AdminComplaintScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
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
