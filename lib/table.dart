// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('User  List'),
//     ),
//     body: SingleChildScrollView(
//       child: DataTable(
//         columns: [
//           DataColumn(label: Text('Name')),
//           DataColumn(label: Text('Email')),
//           DataColumn(label: Text('Category')),
//         ],
//         rows: users.map((user) {
//           return DataRow(cells: [
//             DataCell(Text(user.name)),
//             DataCell(Text(user.email)),
//             DataCell(Text(user.category)),
//           ]);
//         }).toList(),
//       ),
//     ),
//   );
// }
//
//
//
