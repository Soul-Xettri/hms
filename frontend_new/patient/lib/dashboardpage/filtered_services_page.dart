import 'package:flutter/material.dart';
import 'service_item_data.dart'; // Import the shared ServiceItemData class

class FilteredServicesPage extends StatefulWidget {
  final String searchQuery;
  final List<ServiceItemData> filteredServices;

  FilteredServicesPage(
      {required this.searchQuery, required this.filteredServices});

  @override
  _FilteredServicesPageState createState() => _FilteredServicesPageState();
}

class _FilteredServicesPageState extends State<FilteredServicesPage> {
  late TextEditingController _searchController;
  late List<ServiceItemData> _displayedServices;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
    _displayedServices = widget.filteredServices;
  }

  void _updateDisplayedServices(String query) {
    setState(() {
      _displayedServices = widget.filteredServices
          .where((service) =>
              service.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        backgroundColor:
            Colors.blue, // Ensure the AppBar background color is consistent
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              onChanged: _updateDisplayedServices,
              decoration: InputDecoration(
                hintText: 'Search By Keyword',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _displayedServices.map((service) {
                  return ServiceItem(
                    title: service.title,
                    icon: service.icon,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const ServiceItem({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to respective service page
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
