import 'package:flutter/material.dart';

void main() => runApp(IndoreOpen());

class IndoreOpen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IndoreOpen',
      home: ShopListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Shop {
  String name, category;
  bool isOpen;
  Map<String, bool> items;
  Shop(this.name, this.category, this.isOpen, this.items);
}

class ShopListScreen extends StatefulWidget {
  @override
  _ShopListScreenState createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  List<Shop> shops = [
    Shop('Sharma General Store', 'Kirana', true, {
      'Amul Butter 500g': true,
      'Maggi 280g': true,
      'Aashirvaad Atta 5kg': false,
    }),
    Shop('Agarwal Kirana', 'Kirana', false, {
      'Parle-G': true,
      'Tata Salt 1kg': false,
    }),
    Shop('City Medical', 'Pharmacy', true, {
      'Dolo 650': true,
      'Crocin': true,
      'Vicks Vaporub': false,
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IndoreOpen'), backgroundColor: Colors.orange),
      body: ListView.builder(
        itemCount: shops.length,
        itemBuilder: (context, index) {
          final shop = shops[index];
          return ListTile(
            title: Text(shop.name),
            subtitle: Text(shop.category),
            trailing: Chip(
              label: Text(shop.isOpen? 'Open' : 'Closed'),
              backgroundColor: shop.isOpen? Colors.green : Colors.red,
              labelStyle: TextStyle(color: Colors.white),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ShopDetailScreen(shop: shop)),
            ),
          );
        },
      ),
    );
  }
}

class ShopDetailScreen extends StatefulWidget {
  final Shop shop;
  ShopDetailScreen({required this.shop});
  @override
  _ShopDetailScreenState createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  late bool isOpen;
  @override
  void initState() {
    super.initState();
    isOpen = widget.shop.isOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.shop.name)),
      body: Column(
        children: [
          SwitchListTile(
            title: Text('Shop Status', style: TextStyle(fontSize: 18)),
            subtitle: Text(isOpen? 'OPEN' : 'CLOSED'),
            value: isOpen,
            onChanged: (val) => setState(() => isOpen = val),
            activeColor: Colors.green,
          ),
          Divider(),
          Expanded(
            child: ListView(
              children: widget.shop.items.entries.map((item) {
                return CheckboxListTile(
                  title: Text(item.key),
                  subtitle: Text(item.value? 'In Stock' : 'Out of Stock'),
                  value: item.value,
                  onChanged: (val) => setState(() => widget.shop.items[item.key] = val!),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
