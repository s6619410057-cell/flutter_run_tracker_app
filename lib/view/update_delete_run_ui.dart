import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_services.dart';
import 'package:intl/intl.dart';

class UpdateDeleteRunUi extends StatefulWidget {
  Run? run;
  UpdateDeleteRunUi({super.key, required this.run});

  @override
  State<UpdateDeleteRunUi> createState() => _UpdateDeleteRunUiState();
}

class _UpdateDeleteRunUiState extends State<UpdateDeleteRunUi> {
  TextEditingController runWhereCtrl = TextEditingController();
  TextEditingController runPersonCtrl = TextEditingController();
  TextEditingController runDistanceCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    runWhereCtrl.text = widget.run!.runWhere;
    runPersonCtrl.text = widget.run!.runPerson;
    runDistanceCtrl.text = widget.run!.runDistance.toString();
  }

  void editRun() async {
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
    await service.updateRun(widget.run!.id!, run);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('แก้ไขสำเร็จ'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  }

  Future<void> deleteRun() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ยืนยันการลบข้อมูล'),
        content: Text('คุณต้องการลบข้อมูลนี้หรือไม่?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'ยกเลิก',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final service = SupabaseService();
              await service.deleteRun(widget.run!.id!);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('ลบข้อมูลเรียบร้อยแล้ว'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text('ยืนยันการลบข้อมูล',
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 72, 91, 141),
        title: Text(
          'Run Tracker(แก้ไข/ลบ)',
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
                    editRun();
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
                    'บันทึกแก้ไขข้อมูล',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  deleteRun().then((value) {
                    Navigator.pop(context);
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
                  'ลบข้อมูล',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}