import 'package:flutter/material.dart';
import 'package:antoine_online_app/features/store_locator/domain/entities/store_location.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  final StoreLocation store;

  const StoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(store.name, style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            Text(store.address),
            if (store.phone != null) ...[
              const SizedBox(height: 8),
              Text(store.phone!),
            ],
            if (store.email != null) ...[
              const SizedBox(height: 8),
              Text(store.email!),
            ],
            if (store.openingHours != null) ...[
              const SizedBox(height: 8),
              Text('Mon-Fri: ${store.openingHours!.mondayToFriday ?? ''}'),
              Text('Sat: ${store.openingHours!.saturday ?? ''}'),
              Text('Sun: ${store.openingHours!.sunday ?? ''}'),
            ],
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${store.latitude},${store.longitude}');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child: const Text('Get Directions'),
            ),
          ],
        ),
      ),
    );
  }
}
