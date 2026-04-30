import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_services.dart';
import 'package:intl/intl.dart';

class AddRunUi extends StatefulWidget {
  const AddRunUi({super.key});

  @override
  State<AddRunUi> createState() => _AddRunUiState();
}

class _AddRunUiState extends State<AddRunUi> {
  final TextEditingController runWhereCtrl = TextEditingController();
  final TextEditingController runPersonCtrl = TextEditingController();
  final TextEditingController runDistanceCtrl = TextEditingController();

  void saveRun() async {
    if (runWhereCtrl.text.isEmpty ||
        runPersonCtrl.text.isEmpty ||
        runDistanceCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณากรอกข้อมูลให้ครบ'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    Run run = Run(
      runWhere: runWhereCtrl.text,
      runPerson: runPersonCtrl.text,
      runDistance: double.parse(runDistanceCtrl.text),
    );

    final service = SupabaseService();
    await service.insertRun(run);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('บันทึกสำเร็จ'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 72, 91, 141),
        title: Text(
          'Run Tracker(เพิ่ม)',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: 5,
            bottom: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'วิ่งที่ไหน',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                controller: runWhereCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'เช่น สวนสาธารณะ, สนามกีฬา หรือ อื่นๆ',
                ),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'วิ่งกับใคร',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                controller: runPersonCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'เช่น เพื่อน 3 คน, แฟน หรือ อื่นๆ',
                ),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ระยะทาง',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                controller: runDistanceCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'เช่น 1, 5, 11 หรือ อื่นๆ',
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    saveRun();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      35,
                    ),
                  ),
                  child: Text(
                    'บันทึกข้อมูล',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              SizedBox(height: 5),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      runWhereCtrl.clear();
                      runPersonCtrl.clear();
                      runDistanceCtrl.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      35,
                    ),
                  ),
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}