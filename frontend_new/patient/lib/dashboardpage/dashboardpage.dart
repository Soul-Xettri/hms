import 'package:flutter/material.dart';
import 'package:frontend_new/dashboardpage/search.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import the carousel_slider package
import 'package:frontend_new/dashboardpage/searchpage.dart';
import 'package:frontend_new/dashboardpage/filtered_services_page.dart';
import 'service_item_data.dart'; // Import the shared ServiceItemData class
import '../Controller/AccController.dart';
import '../global.dart';
import 'api for profile/profile.dart';
import 'api for medical record/medicalrecordpage.dart';
import 'prescriptionpage.dart';
import 'profile/patientpage.dart';

class DashboardPage extends StatefulWidget {
  final String? firstName;

  const DashboardPage({super.key, required this.firstName});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0; // To keep track of the selected index
  String _searchQuery = '';

  final List<ServiceItemData> services = [
    ServiceItemData(title: 'General Practice', icon: Icons.local_hospital),
    ServiceItemData(title: 'Internal Medicine', icon: Icons.healing),
    ServiceItemData(title: 'Cardiology', icon: Icons.favorite),
    ServiceItemData(title: 'Psychiatric', icon: Icons.psychology),
    ServiceItemData(title: 'Pediatrics', icon: Icons.child_care),
    ServiceItemData(title: 'Dermatology', icon: Icons.face),
    ServiceItemData(title: 'Gynaecology', icon: Icons.pregnant_woman),
    ServiceItemData(title: 'Gastroenterology', icon: Icons.lunch_dining),
    ServiceItemData(title: 'Orthopedic', icon: Icons.accessibility),
    ServiceItemData(title: 'Nephrology', icon: Icons.water_damage),
    ServiceItemData(title: 'Hematology', icon: Icons.bloodtype),
    ServiceItemData(title: 'Psychiatric', icon: Icons.psychology_outlined),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PatientPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = context.read<PaDataProvider>().account?.value;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopSection(context, data),
            _buildCarouselSection(),
            _buildActionButtons(context),
            _buildServicesSection(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildTopSection(BuildContext context, dynamic data) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome',
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          const SizedBox(height: 8.0),
          Text(
            '${data?.fname ?? 'User'} ${data?.lname ?? ''}',
            style: const TextStyle(color: Colors.white, fontSize: 24.0),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildSearchBox(context)),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              paId: data?.paId,
                            )),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });

                // Navigate to the filtered services page
                final filteredServices = services
                    .where((service) => service.title
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()))
                    .toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilteredServicesPage(
                      searchQuery: _searchQuery,
                      filteredServices: filteredServices,
                    ),
                  ),
                );
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselSection() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 140.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 19 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        viewportFraction: 0.8,
      ),
      items: [
        'assets/image/slider.jpg',
        'assets/image/slider1.jpg',
        'assets/image/slider2.jpg',
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(i),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildProfileOption(
              'Appointment', Icons.calendar_today, Colors.purple, context),
          _buildProfileOption(
              'Medical Record', Icons.medical_services, Colors.blue, context),
          _buildProfileOption(
              'Prescription', Icons.description, Colors.green, context),
        ],
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Services',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: services.map((service) {
              return ServiceItem(
                title: service.title,
                icon: service.icon,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const ServiceItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.blue),
          const SizedBox(height: 8.0),
          Text(title,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

Widget _buildProfileOption(
    String title, IconData icon, Color color, BuildContext context) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        // Navigate to the respective page based on the title
        if (title == 'Prescription') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyPrescriptionPage()),
          );
        } else if (title == 'Medical Record') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploadImagePage()),
          );
        } else if (title == 'Appointment') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        }
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8.0),
            Text(title,
                style: const TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    ),
  );
}
