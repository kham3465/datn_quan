// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_background_geolocation_example/view/model/user_type_model.dart';
// import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

// class UserListScreenSailor extends StatefulWidget {
//   const UserListScreenSailor({Key? key}) : super(key: key);

//   @override
//   _UserListScreenSailorState createState() => _UserListScreenSailorState();
// }

// class _UserListScreenSailorState extends State<UserListScreenSailor> {
//   late Future<List<User>> _usersFuture;

//   @override
//   void initState() {
//     super.initState();
//     _usersFuture = _fetchUsers();
//   }

//   Future<List<User>> _fetchUsers() async {
//     try {
//       final res = await ApiRequest.getListUserSailor();
//       if (res.code == "200") {
//         List<dynamic> jsonList = res.data;
//         List<User> users = jsonList.map((json) => User.fromJson(json)).toList();
//         return users;
//       } else {
//         throw Exception('Failed to load users: ${res.message}');
//       }
//     } catch (e) {
//       throw Exception('Failed to load users: $e');
//     }
//   }

//   void _navigateToUserDetail(User user) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => UserDetailScreen(user: user),
//       ),
//     );
//   }

//   void _confirmDeleteUser(User user) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Xác nhận xóa người dùng"),
//           content: Text("Bạn có chắc chắn muốn xóa người dùng ${user.name}?"),
//           actions: <Widget>[
//             TextButton(
//               child: Text("Hủy"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text("Xóa"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _deleteUser(user.id!);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteUser(int id) async {
//     try {
//       // Gọi API hoặc hàm để xóa người dùng
//       final res = await ApiRequest.deleteUser(id);
//       if (res.code == "200") {
//         // Xử lý thành công, có thể cập nhật lại danh sách người dùng
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Đã xóa người dùng"),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         setState(() {
//           // Cập nhật lại danh sách người dùng sau khi xóa
//           _usersFuture = _fetchUsers();
//         });
//       } else {
//         throw Exception('Failed to delete user: ${res.message}');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Đã xảy ra lỗi khi xóa người dùng: $e"),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Danh sách nhà cung cấp'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.white, Colors.grey.shade200],
//           ),
//         ),
//         child: FutureBuilder<List<User>>(
//           future: _usersFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasData) {
//               List<User> users = snapshot.data!;
//               return ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   User user = users[index];
//                   return Card(
//                     elevation: 3,
//                     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: ListTile(
//                       onTap: () => _navigateToUserDetail(user),
//                       onLongPress: () => _confirmDeleteUser(user),
//                       contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                       leading: CircleAvatar(
//                         backgroundImage: user.ava != null
//                             ? NetworkImage(user.ava!)
//                             : AssetImage('assets/default_avatar.png') as ImageProvider,
//                       ),
//                       title: Text(
//                         user.name ?? '',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildInfoRow('Email', user.email ?? ''),
//                           _buildInfoRow('Số điện thoại', user.phone ?? ''),
//                           _buildInfoRow(
//                             'Ngày sinh',
//                             user.dob != null
//                                 ? DateFormat('dd/MM/yyyy').format(user.dob!)
//                                 : '',
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               '$title:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Text(value),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class UserDetailScreen extends StatelessWidget {
//   final User user;

//   const UserDetailScreen({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thông tin người dùng'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Container(
//         margin: EdgeInsets.all(16),
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 3,
//               blurRadius: 7,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: user.ava != null
//                       ? DecorationImage(
//                           image: NetworkImage(user.ava!),
//                           fit: BoxFit.cover,
//                         )
//                       : null,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildInfoRow('Tên', user.name ?? ''),
//                     _buildInfoRow('Email', user.email ?? ''),
//                     _buildInfoRow('Số điện thoại', user.phone ?? ''),
//                     _buildInfoRow(
//                       'Ngày sinh',
//                       user.dob != null
//                           ? DateFormat('dd/MM/yyyy').format(user.dob!)
//                           : '',
//                     ),
//                     _buildInfoRow('Địa chỉ', user.address ?? ''),
//                     _buildInfoRow('Công ty', user.company ?? ''),
//                     _buildInfoRow('Vai trò', user.role ?? ''),
//                     _buildInfoRow('Level', user.level ?? ''),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String title, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               '$title:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }