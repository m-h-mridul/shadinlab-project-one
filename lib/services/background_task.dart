// import 'package:background_fetch/background_fetch.dart';

// void backgroundFetchHeadlessTask(HeadlessTask task) async {
//   var taskId = task.taskId;
//     print("your_task_id from back ground task");
//     print("${BackgroundFetch} Headless event received.");
  
// }

// Future<void> initPlatformState() async {
// // Configure BackgroundFetch.
//   var status = await BackgroundFetch.configure(
//       BackgroundFetchConfig(
//         minimumFetchInterval: 15,
//         forceAlarmManager: false,
//         stopOnTerminate: false,
//         startOnBoot: true,
//         enableHeadless: true,
//         requiresBatteryNotLow: false,
//         requiresCharging: false,
//         requiresStorageNotLow: false,
//         requiresDeviceIdle: false,
//         requiredNetworkType: NetworkType.NONE,
//       ),
//       _onBackgroundFetch,
//       _onBackgroundFetchTimeout);
//   print("[BackgroundFetch] configure success: $status");
// // Schedule backgroundfetch for the 1st time it will execute with 1000ms delay.
// // where device must be powered (and delay will be throttled by the OS).
//   BackgroundFetch.scheduleTask(TaskConfig(
//       taskId: "com.dltlabs.task",
//       delay: 1000,
//       periodic: false,
//       stopOnTerminate: false,
//       enableHeadless: true));
// }

// void _onBackgroundFetchTimeout(String taskId) {
//   print("[BackgroundFetch] TIMEOUT: $taskId");
//   BackgroundFetch.finish(taskId);
// }

// void _onBackgroundFetch(String taskId) async {
//   if (taskId == "your_task_id") {
//     print("[BackgroundFetch] Event received");
//   }
// }
