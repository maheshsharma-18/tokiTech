import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AdminModule {
  dashboard('Dashboard', Icons.dashboard_rounded),
  attendance('Attendance', Icons.check_circle_outline),
  grades('Grades', Icons.school_outlined),
  students('Students', Icons.people_alt_outlined),
  teachers('Teachers', Icons.person_outline),
  classes('Classes', Icons.class_outlined),
  timetable('Timetable', Icons.schedule_rounded),
  homework('Homework', Icons.assignment_outlined),
  events('Events & Calendar', Icons.event_note_outlined),
  tickets('Tickets', Icons.confirmation_number_outlined),
  fleet('Fleet', Icons.directions_bus_outlined),
  superAdmin('Schools', Icons.domain_outlined);

  const AdminModule(this.label, this.icon);

  final String label;
  final IconData icon;
}

final adminMenuProvider = StateNotifierProvider<MenuController, AdminModule>((ref) {
  return MenuController();
});

class MenuController extends StateNotifier<AdminModule> {
  MenuController() : super(AdminModule.dashboard);

  void select(AdminModule module) => state = module;
}
