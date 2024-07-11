import 'package:flutter/material.dart';

class TermsAndPoliciesScreen extends StatelessWidget {
  TermsAndPoliciesScreen({Key? key}) : super(key: key);

  final List<String> policies = [
    // Sample Terms and Policies for a Hospital
    '1. Patient Care and Rights',
    'Patient Rights: Every patient has the right to respectful and considerate care, regardless of race, religion, gender, or socioeconomic status.',
    'Informed Consent: Patients have the right to receive information about their condition, proposed treatment options, risks, and benefits before consenting to any medical procedure.',
    'Privacy and Confidentiality: Patient health information is confidential and protected under HIPAA regulations. Only authorized personnel have access to patient records.',
    '',
    '2. Medical Services and Procedures',
    'Quality of Care: We strive to provide high-quality medical care and services consistent with professional standards and best practices.',
    'Emergency Care: The hospital provides emergency medical services 24/7 to treat patients with urgent medical conditions promptly.',
    '',
    '3. Billing and Financial Policies',
    'Billing Information: Patients will receive clear and accurate billing statements detailing services rendered and associated costs.',
    'Insurance: We accept various insurance plans and will work with patients to verify coverage and facilitate insurance claims.',
    '',
    '4. Safety and Security',
    'Patient Safety: The hospital maintains a safe environment for patients, staff, and visitors, following infection control protocols and ensuring the safety of medical equipment.',
    'Security Measures: Security personnel are on-site to maintain a secure environment and respond to any safety concerns.',
    '',
    '5. Visitor Policies',
    'Visiting Hours: Specific visiting hours are established to ensure patients\' rest and recovery.',
    'Visitor Guidelines: Visitors must comply with hospital policies regarding behavior, infection control, and patient confidentiality.',
    '',
    '6. Complaints and Grievances',
    'Complaint Process: Patients have the right to express concerns or complaints regarding their care or services received. The hospital has a formal process to address and resolve complaints promptly.',
    '',
    '7. Research and Education',
    'Research: The hospital may conduct medical research with appropriate patient consent and adherence to ethical guidelines.',
    'Medical Education: The hospital supports medical education and training programs for healthcare professionals, contributing to the advancement of medical knowledge and patient care.',
    '',
    '8. Ethics and Decision Making',
    'Ethical Standards: Healthcare providers adhere to ethical principles in patient care, respecting patient autonomy and making decisions in the patient\'s best interest.',
    'End-of-Life Care: Policies and procedures are in place to support patients and families in end-of-life decision-making and care.',
    '',
    '9. Continuity of Care',
    'Discharge Planning: Discharge planning ensures a smooth transition for patients from hospital to home or another care setting, including coordination of follow-up care and medications.',
    '',
    '10. Amendments and Updates',
    'Policy Updates: These terms and policies are subject to periodic review and updates. Any changes will be communicated to patients, staff, and the community as appropriate.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Policies'),
      ),
      body: ListView.builder(
        itemCount: policies.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              policies[index],
              style: TextStyle(fontSize: 16.0),
            ),
          );
        },
      ),
    );
  }
}
