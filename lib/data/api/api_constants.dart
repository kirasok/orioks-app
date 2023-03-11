class ApiConstants {
  static const baseUrl = "https://orioks.miet.ru/api/v1";
  static const authEndpoint = "/auth";
  static const scheduleEndpoint = "/schedule";
  static const groupListEndpoint = "$scheduleEndpoint/groups";
  static const timetableEndpoint = "$scheduleEndpoint/timetable";
  static const studentEndpoint = "/student";
  static const disciplinesEndpoint = "$studentEndpoint/disciplines";
  static const eventsEndpoint = "/events";
  static const academicDebtsEndpoint = "$studentEndpoint/academic-debts";
  static const tokensEndpoint = "$studentEndpoint/tokens";
  static const userAgent = "orioks_app/0.1 Android";
}
