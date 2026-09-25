
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'services/background_removal_service.dart';
import 'services/gemini_product_service.dart';

void main() {
  runApp(const KalaSetuApp());
}

class KalaSetuApp extends StatelessWidget {
  const KalaSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KalaSetu',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'sans',
        scaffoldBackgroundColor: const Color(0xFFF8F7F3),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B3A2F),
          brightness: Brightness.light,
        ),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  final pages = const [
    HomePage(),
    AddProductPage(),
    ProductsPage(),
    OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFF2DED8),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add_box_outlined), selectedIcon: Icon(Icons.add_box), label: 'Add Product'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'My Products'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Orders'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B3A2F),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('KalaSetu', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    Text('Digital marketplace for artisans', style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7E332A), Color(0xFFA95A46)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Turn your craft\ninto a digital product.', style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w800, height: 1.12)),
                SizedBox(height: 10),
                Text('Just add a photo and tell us about your craft. KalaSetu does the cataloging.', style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.45)),
                SizedBox(height: 18),
                Row(
                  children: [
                    Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
                    SizedBox(width: 7),
                    Text('Photo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    SizedBox(width: 18),
                    Icon(Icons.mic_none_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 7),
                    Text('Voice', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    SizedBox(width: 18),
                    Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                    SizedBox(width: 7),
                    Text('AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Quick actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _QuickCard(icon: Icons.add_a_photo_outlined, title: 'Add Product', subtitle: 'Create with AI', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AddProductPage()));
              })),
              const SizedBox(width: 12),
              Expanded(child: _QuickCard(icon: Icons.inventory_2_outlined, title: 'My Products', subtitle: 'View catalogue', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductsPage()));
              })),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Your impact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              Text('This month', style: TextStyle(color: Colors.black45)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _StatCard(number: '7', label: 'Products')),
              SizedBox(width: 10),
              Expanded(child: _StatCard(number: '₹7.6k', label: 'Sales')),
              SizedBox(width: 10),
              Expanded(child: _StatCard(number: '19', label: 'Orders')),
            ],
          ),
          const SizedBox(height: 24),
          const Text('How KalaSetu works', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          const _StepTile(number: '01', icon: Icons.photo_camera_outlined, title: 'Capture your craft', subtitle: 'Take a clear photo or choose one from your gallery.'),
          const _StepTile(number: '02', icon: Icons.mic_none_rounded, title: 'Speak naturally', subtitle: 'Describe your product in your own language.'),
          const _StepTile(number: '03', icon: Icons.auto_awesome, title: 'AI creates the listing', subtitle: 'Title, description, category and tags are generated automatically.'),
        ],
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _QuickCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(color: const Color(0xFFF2DED8), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: const Color(0xFF8B3A2F)),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 3),
          Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12)),
        ]),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String number;
  final String label;
  const _StatCard({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(children: [
        Text(number, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        const SizedBox(height: 3),
        Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
      ]),
    );
  }
}

class _StepTile extends StatelessWidget {
  final String number;
  final IconData icon;
  final String title;
  final String subtitle;
  const _StepTile({required this.number, required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Row(children: [
        Text(number, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF8B3A2F))),
        const SizedBox(width: 14),
        CircleAvatar(backgroundColor: const Color(0xFFF2DED8), child: Icon(icon, color: const Color(0xFF8B3A2F), size: 20)),
        const SizedBox(width: 13),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12, height: 1.3)),
        ])),
      ]),
    );
  }
}

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  bool processing = false;
  bool voiceAdded = false;
    File? selectedImage;
  final ImagePicker picker = ImagePicker();
static const String removeBgApiKey =
    String.fromEnvironment('REMOVE_BG_API_KEY');
 static const String geminiApiKey =
    String.fromEnvironment('GEMINI_API_KEY');
  final SpeechToText speech = SpeechToText();
bool isListening = false;
String voiceText = '';
Future<void> toggleListening() async {
  if (isListening) {
    await speech.stop();

    setState(() {
      isListening = false;
    });

    return;
  }

  final available = await speech.initialize(
    debugLogging: true,
    onStatus: (status) {
      if (status == 'done' || status == 'notListening') {
        if (mounted) {
          setState(() {
            isListening = false;
          });
        }
      }
    },
    onError: (error) {
  if (mounted) {
    setState(() {
      isListening = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Speech error: ${error.errorMsg}',
        ),
      ),
    );
  }
},
  );

  if (!available) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Speech recognition is not available on this device.',
        ),
      ),
    );

    return;
  }
final systemLocale = await speech.systemLocale();
final availableLocales = await speech.locales();

print('SYSTEM LOCALE: ${systemLocale?.localeId}');
print(
  'AVAILABLE LOCALES: ${availableLocales.map((e) => '${e.name} (${e.localeId})').join(', ')}',
);
  setState(() {
    isListening = true;
  });

  await speech.listen(
  onResult: (result) {
    if (!mounted) return;

    setState(() {
      voiceText = result.recognizedWords;
      voiceAdded = voiceText.trim().isNotEmpty;
    });
  },
 listenOptions: SpeechListenOptions(
  partialResults: true,
  listenFor: const Duration(seconds: 30),
  pauseFor: const Duration(seconds: 5),
  listenMode: ListenMode.dictation,
),
);
}

  Future<void> pickImage() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add product photo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 18),

                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFF2DED8),
                    child: Icon(
                      Icons.camera_alt,
                      color: Color(0xFF8B3A2F),
                    ),
                  ),
                  title: const Text('Take a photo'),
                  subtitle: const Text('Use camera'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),

                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFF2DED8),
                    child: Icon(
                      Icons.photo_library,
                      color: Color(0xFF8B3A2F),
                    ),
                  ),
                  title: const Text('Choose from gallery'),
                  subtitle: const Text('Select an existing photo'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null) return;

    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 90,
    );

    if (image == null) return;

    setState(() {
      selectedImage = File(image.path);
    });
  }

 Future<void> generate() async {
  if (selectedImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please add a product photo first.'),
      ),
    );
    return;
  }

  if (removeBgApiKey.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Background removal API key is missing.'),
      ),
    );
    return;
  }

  if (geminiApiKey.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gemini API key is missing.'),
      ),
    );
    return;
  }

  setState(() {
    processing = true;
  });

  try {
    // Step 1: Remove background
    final cleanedImage =
        await BackgroundRemovalService.removeBackground(
      image: selectedImage!,
      apiKey: removeBgApiKey,
    );

    // Step 2: Identify product using Gemini
    final productName =
        await GeminiProductService.identifyProduct(
      image: cleanedImage,
      apiKey: geminiApiKey,
    );

    if (!mounted) return;

    setState(() {
      processing = false;
    });

    // Step 3: Open preview
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductPreviewPage(
          image: cleanedImage,
          productName: productName,
        ),
      ),
    );
  } catch (e) {
    if (!mounted) return;

    setState(() {
      processing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('AI identification failed: $e'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product', style: TextStyle(fontWeight: FontWeight.w800)), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Create a listing in seconds', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
          const SizedBox(height: 7),
          const Text('No typing required. Add a photo and tell KalaSetu about your craft.', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 24),
          Container(
            height: 230,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black12),
            ),
            child: InkWell(
  borderRadius: BorderRadius.circular(24),
  onTap: pickImage,
  child: selectedImage == null
      ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: Color(0xFFF2DED8),
              child: Icon(
                Icons.camera_alt_rounded,
                size: 32,
                color: Color(0xFF8B3A2F),
              ),
            ),
            SizedBox(height: 14),
            Text(
              'Add product photo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Tap to take a photo or choose from gallery',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        )
      : Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.file(
                selectedImage!,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Color(0xFF8B3A2F),
                  ),
                  onPressed: pickImage,
                ),
              ),
            ),
          ],
        ),
),
),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.black12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Describe your product', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: const Color(0xFFF8F7F3), borderRadius: BorderRadius.circular(16)),
                child: Row(children: [
          Expanded(
  child: Text(
    voiceText.isEmpty
        ? (isListening
            ? 'Listening... speak naturally'
            : 'Tap the mic and speak naturally')
        : voiceText,
    style: TextStyle(
      color: voiceText.isEmpty
          ? Colors.black54
          : Colors.black87,
    ),
  ),
),
                  IconButton(
                    onPressed: toggleListening,
                    icon: Icon(voiceAdded ? Icons.check_circle : Icons.mic_rounded, color: const Color(0xFF8B3A2F)),
                  ),
                ]),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 54,
            child: FilledButton.icon(
              onPressed: processing ? null : generate,
              icon: processing ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.auto_awesome),
              label: Text(processing ? 'Creating your listing...' : 'Generate with AI', style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductPreviewPage extends StatelessWidget {
  const ProductPreviewPage({
    super.key,
    this.image,
    this.productName,
  });

  final File? image;
  final String? productName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Listing Preview', style: TextStyle(fontWeight: FontWeight.w800)), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
Container(
  height: 230,
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    color: const Color(0xFFE9E2D8),
  ),
  clipBehavior: Clip.antiAlias,
  child: image != null
      ? Image.file(
          image!,
          fit: BoxFit.cover,
        )
      : const Center(
          child: Icon(
            Icons.image_outlined,
            size: 72,
            color: Colors.black26,
          ),
        ),
),
          const SizedBox(height: 18),
          const Row(children: [
            Icon(Icons.auto_awesome, color: Color(0xFF8B3A2F), size: 20),
            SizedBox(width: 7),
            Text('AI-generated listing', style: TextStyle(color: Color(0xFF8B3A2F), fontWeight: FontWeight.w800)),
          ]),
          const SizedBox(height: 10),
         Text(
  productName ?? 'Product identified by AI',
  style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
  ),
),
          const SizedBox(height: 8),
const Text(
  'Every handmade piece is a celebration of traditional craftsmanship, creativity, and cultural heritage—carefully crafted to carry a story from the hands of the artisan to your home.',
  style: TextStyle(
    fontSize: 15,
    height: 1.5,
  ),
),
          const SizedBox(height: 18),
          Wrap(spacing: 8, runSpacing: 8, children: const [
            Chip(label: Text('Handmade')),
            Chip(label: Text('Terracotta')),
            Chip(label: Text('Home Decor')),
            Chip(label: Text('Festive')),
          ]),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Suggested price', style: TextStyle(color: Colors.black54)),
                SizedBox(height: 4),
                Text('₹299', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
              ]),
              Text('AI suggestion', style: TextStyle(color: Color(0xFF8B3A2F), fontWeight: FontWeight.w700)),
            ]),
          ),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Edit'))),
            const SizedBox(width: 12),
            Expanded(child: FilledButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.publish_rounded), label: const Text('Publish'))),
          ]),
        ],
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Products', style: TextStyle(fontWeight: FontWeight.w800)), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
            Text('Your catalogue', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
            Chip(label: Text('3 products')),
          ]),
          const SizedBox(height: 14),
          _ProductCard(title: 'Terracotta Diya Set', category: 'Home Decor', price: '₹299', icon: Icons.local_fire_department_outlined),
          _ProductCard(title: 'Handwoven Basket', category: 'Handicrafts', price: '₹699', icon: Icons.shopping_basket_outlined),
          _ProductCard(title: 'Blue Pottery Vase', category: 'Decor', price: '₹1,299', icon: Icons.spa_outlined),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String title, category, price;
  final IconData icon;
  const _ProductCard({required this.title, required this.category, required this.price, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        Container(width: 72, height: 72, decoration: BoxDecoration(color: const Color(0xFFE9E2D8), borderRadius: BorderRadius.circular(16)), child: Icon(icon, size: 32, color: const Color(0xFF8B3A2F))),
        const SizedBox(width: 13),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(category, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          const SizedBox(height: 6),
          Text(price, style: const TextStyle(fontWeight: FontWeight.w900)),
        ])),
        const Icon(Icons.chevron_right_rounded, color: Colors.black38),
      ]),
    );
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders', style: TextStyle(fontWeight: FontWeight.w800)), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _OrderCard(id: '#KS1024', product: 'Terracotta Diya Set', amount: '₹598', status: 'Confirmed', icon: Icons.local_fire_department_outlined),
          _OrderCard(id: '#KS1021', product: 'Handwoven Basket', amount: '₹699', status: 'Shipped', icon: Icons.shopping_basket_outlined),
          _OrderCard(id: '#KS1018', product: 'Blue Pottery Vase', amount: '₹1,299', status: 'Delivered', icon: Icons.spa_outlined),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String id, product, amount, status;
  final IconData icon;
  const _OrderCard({required this.id, required this.product, required this.amount, required this.status, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        CircleAvatar(backgroundColor: const Color(0xFFF2DED8), child: Icon(icon, color: const Color(0xFF8B3A2F))),
        const SizedBox(width: 13),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(id, style: const TextStyle(fontSize: 12, color: Colors.black45)),
          const SizedBox(height: 3),
          Text(product, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.w900)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFFE7F2E9), borderRadius: BorderRadius.circular(20)),
          child: Text(status, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        ),
      ]),
    );
  }
}
