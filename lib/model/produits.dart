class Produit {
  final int id;
  final String nom;
  final double prix;

  Produit({
    required this.id,
    required this.nom,
    required this.prix,
  });

  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      id: json['id'],
      nom: json['nom'],
      prix: json['prix'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prix': prix,
    };
  }
}
