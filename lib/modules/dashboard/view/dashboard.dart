import 'package:beinex_test/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants/text_styles.dart';
import '../cubit/dashboard_cubit.dart';
import '../data_model/data_grid_response.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<DataGridResponse> mockListItem = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DashboardCubit>(context).getMockData();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: greyDark,
        title: Text("Dasbhoard", style: largeText),
      ),
      body: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state is DashboardLoading) {
            EasyLoading.show(status: 'Loading...');
          } else if (state is DashboardLoaded) {
            EasyLoading.dismiss();
            mockListItem = state.mocklistdata;
          } else if (state is DashboardLoadedError) {
            EasyLoading.dismiss();
            showSnackBar(state.error, context);
          }
        },
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: body(context),
          );
        },
        buildWhen: (previousState, state) {
          return state is DashboardLoaded;
        },
      ),
    );
  }

  Widget body(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 0,
          child: DataTable(
            dataRowMinHeight: 48.0,
            columnSpacing: 10,
            headingTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            headingRowColor: MaterialStateProperty.resolveWith(
                    (states) => colorBlue
            ),
            columns: const [
              DataColumn(label: Text("ID")),
              DataColumn(label: Text("Item ID")),
            ],
            rows: mockListItem
                .map((data) => DataRow(cells: [
                      DataCell(
                        Text(
                          data.id.toString(),
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      DataCell(
                        Text(
                          data.itemId.toString(),
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ]))
                .toList(),
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              dataRowMaxHeight: double.infinity,
              dataRowMinHeight: 50,
              columnSpacing: 10,
              headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
              headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => colorBlue
              ),
              columns: const [
                DataColumn(label: Text("Title")),
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Status")),
                DataColumn(label: Text("Type 1")),
                DataColumn(label: Text("Type 2")),
                DataColumn(label: Text("Type 1")),
                DataColumn(label: Text("Type 2")),
              ],
              rows: mockListItem
                  .map((data) => DataRow(cells: [
                        DataCell(SizedBox(
                          width: 200,
                          child: Text(
                            data.title,
                          ),
                        )),
                        DataCell(
                          Text(
                            data.date.toString(),
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        DataCell(
                          Text(data.active ?'Disabled':'Active',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        DataCell(Text(data.itemType1!.value.toString())),
                        DataCell(Text(data.itemType1!.value.toString())),
                        DataCell(Text(data.itemType2!.value.toString())),
                        DataCell(Text(data.itemType2!.value.toString())),
                      ]))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  void showSnackBar(String message, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
