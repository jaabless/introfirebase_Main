import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms and Privacy'), actions: []),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
              'his study was conducted by the researchers to assess the current systems used in booking appointments and transactions with doctors. The study findings reveal that patients face difficulties in arranging appointments, especially now that physical interactions are limited by the COVID-19 pandemic. With this, the researchers have seen a gap wherein they can fit in and provide an IT-based solution. The researchers aimed to implement a Doctor Appointment App developed using Flutter that will serve as a platform that streamlines appointment processes of patients to doctors. The researchers developed the said application and presented it to the target end-users. The study showed that the developed application has great potential in providing the pre-defined needs and requirements of the respondents and intended users'),
        ),
      ),
    );
  }
}
