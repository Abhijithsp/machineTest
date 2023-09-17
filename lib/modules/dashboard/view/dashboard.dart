import 'package:beinex_test/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants/text_styles.dart';
import '../../../utils/router/router_variables.dart';
import '../cubit/dashboard_cubit.dart';
import '../data_model/data_grid_response.dart';
import '../data_model/pass_mock_data.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<DataGridResponse> mockListItem = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
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
          return mockListItem.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: body(context),
                )
              : Center(child: CircularProgressIndicator());
        },
        buildWhen: (previousState, state) {
          return state is DashboardLoaded;
        },
      ),
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: DataTable(
              border: TableBorder.all(width: 1, style: BorderStyle.solid),
              dataRowMaxHeight: double.infinity,
              dataRowMinHeight: 50,
              headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
              headingRowColor:
                  MaterialStateProperty.resolveWith((states) => colorBlue),
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
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(width: 1, style: BorderStyle.solid),
                showCheckboxColumn: false,
                dataRowMaxHeight: double.infinity,
                dataRowMinHeight: 50,

                headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
                headingRowColor:
                    MaterialStateProperty.resolveWith((states) => colorBlue),
                columns: const [
                  DataColumn(label: Text("Title")),
                  DataColumn(label: Text("Date")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Column(
                    children: [
                      Text("Item Types"),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Type 1"),
                              SizedBox(width: 20,),
                              Text("Type 2"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
                  DataColumn(label: Column(
                    children: [
                      Text("Levels"),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Level 1"),
                              SizedBox(width: 20,),
                              Text("Level 2"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
                rows: mockListItem
                    .map((data) => DataRow(
                            color: data.active == false
                                ? MaterialStateProperty.all<Color>(Colors.blueGrey)
                                : MaterialStateProperty.all<Color>(Colors.white),
                            onSelectChanged: (newValue) {
                              if (data.active == true) {
                                Navigator.pushNamed(context, details,
                                    arguments: MockPassingData(data));
                              }
                            },
                            cells: [
                              DataCell(Text(
                                data.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )),
                              DataCell(
                                onTap: () {
                                  if(data.overdue==false){
                                    _selectDate(context);
                                  }
                                },
                                Text(
                                  DateFormat('dd MMM yyyy').format((data.date!)),
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ),
                              DataCell(
                                Text(
                                  data.active ? 'True' : 'False',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ),
                              DataCell(Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(data.itemType1?.value.toString() ?? "0"),
                                      SizedBox(width: 40,),
                                      Text(data.itemType2?.value.toString() ?? "0")
                                    ],
                                  ),

                                ],
                              )),
                              DataCell(Column(
                                children: [
                                  Row(
                                    children: [
                                      data.level1!.isNotEmpty ? Text(data.level1?[0].value.toString() ?? "0") : Text(""),
                                      SizedBox(width: 30,),
                                      data.level2!.isNotEmpty ? Text(data.level2?[0].value.toString() ?? "0") : Text(""),

                                    ],
                                  ),

                                ],
                              )),

                            ]))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));

  }
  void showSnackBar(String message, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
