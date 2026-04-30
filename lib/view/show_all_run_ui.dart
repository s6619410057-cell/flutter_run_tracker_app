import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_services.dart';
import 'package:flutter_run_tracker_app/view/add_run_ui.dart';
import 'package:flutter_run_tracker_app/view/update_delete_run_ui.dart';

class ShowAllRunUi extends StatefulWidget {
  const ShowAllRunUi({super.key});

  @override
  State<ShowAllRunUi> createState() => _ShowAllRunUiState();
}

class _ShowAllRunUiState extends State<ShowAllRunUi> {
  List<Run> run = [];

  final Service = SupabaseService();

  void LoadAllRun() async {
    final data = await Service.getAllRun();
    setState(() {
      run = data;
    });
  }

  @override
  void initState() {
    LoadAllRun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 72, 91, 141),
        title: Text(
          'All Run',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: run.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 5,
                      bottom: 5,
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateDeleteRunUi(
                              run: run[index],
                            ),
                          ),
                        ).then((value) {
                          LoadAllRun();
                        });
                      },
                      leading: Image.asset(
                        'assets/images/run_img.png',
                      ),
                      trailing: Icon(
                        Icons.info,
                        color: const Color.fromARGB(255, 72, 91, 141),
                      ),
                      title: Text(
                        'วิ่งที่ไหน: ${run[index].runWhere}',
                      ),
                      subtitle: Text(
                        'วิ่งไปเท่าไหร่: ${run[index].runDistance} กม.',
                      ),
                      tileColor: index % 2 == 0
                          ? Color.fromARGB(255, 158, 171, 206)
                          : Color.fromARGB(255, 213, 220, 238),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRunUi(),
            ),
          ).then((value) {
            LoadAllRun();
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 72, 91, 141),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}