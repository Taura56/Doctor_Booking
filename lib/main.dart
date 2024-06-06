import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Appointment Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Doctor> doctors = [
    Doctor(name: 'Dr. John Doe', specialization: 'Cardiologist'),
    Doctor(name: 'Dr. Jane Smith', specialization: 'Pediatrician'),
    Doctor(name: 'Dr. Michael Johnson', specialization: 'Dermatologist'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Appointment Booking'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doctors[index].name),
            subtitle: Text(doctors[index].specialization),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AppointmentScreen(doctor: doctors[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AppointmentScreen extends StatefulWidget {
  final Doctor doctor;

  AppointmentScreen({required this.doctor});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Doctor: ${widget.doctor.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Specialization: ${widget.doctor.specialization}'),
            SizedBox(height: 16),
            Text(
              'Enter Date:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                hintText: 'dd/mm/yyyy',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _bookAppointment(context),
              child: Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }

  void _bookAppointment(BuildContext context) {
    // Here, you would save the appointment details to a database
    // or perform any other necessary operations

    // Navigate to the confirmation screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentConfirmationScreen(
          doctor: widget.doctor,
          date: _dateController.text,
        ),
      ),
    );
  }
}

class AppointmentConfirmationScreen extends StatelessWidget {
  final Doctor doctor;
  final String date;

  AppointmentConfirmationScreen({required this.doctor, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Confirmation'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Congratulations!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Your appointment with ${doctor.name} (${doctor.specialization}) has been booked for $date.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Doctor {
  final String name;
  final String specialization;

  Doctor({required this.name, required this.specialization});
}
