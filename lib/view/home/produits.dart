import 'package:flutter/material.dart';
import 'package:flutter_hello_word_app/model/produits.dart';
import 'package:flutter_hello_word_app/service/api_service.dart';

import '../../res/assets/image_assets.dart';

class ProduitsPage extends StatefulWidget {
  const ProduitsPage({Key? key}) : super(key: key);

  @override
  _ProduitsPageState createState() => _ProduitsPageState();
}

class _ProduitsPageState extends State<ProduitsPage> {
  late Future<List<Produit>> futureProduits;

  @override
  void initState() {
    super.initState();
    print("Bonjour, monde 4!");
    futureProduits = ApiService().fetchProduitsForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Produit>>(
        future: futureProduits,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return ProduitsCard(item: item);
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class ProduitsCard extends StatelessWidget {
  final Produit item;

  const ProduitsCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              ImageAssets.produiLigne,
              fit: BoxFit.cover,
              height: 230,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, size: 20);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nom,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.prix} dt',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
