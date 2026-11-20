import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const StephanieApp());
}

// COULEURS DE L'APPLICATION
const Color bleuFonce = Color(0xFF123B70);
const Color bleuClair = Color(0xFF55A6E8);
const Color couleurFond = Color(0xFFF3F7FC);

// APPLICATION PRINCIPALE
class StephanieApp extends StatelessWidget {
  const StephanieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon CV - Stephanie',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: bleuFonce,
          primary: bleuFonce,
          secondary: bleuClair,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: couleurFond,
        appBarTheme: const AppBarTheme(
          backgroundColor: bleuFonce,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// ==========================================
// PAGE DE CONNEXION
// ==========================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;

  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username == 'stephanie' && password == '123456') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Identifiant ou mot de passe incorrect.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 48,
                      backgroundColor: Color(0xFFE2EFFD),
                      child: Icon(Icons.person, size: 55, color: bleuFonce),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bienvenue !',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: bleuFonce,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Connectez-vous pour découvrir mon CV.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Identifiant',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      onSubmitted: (_) => login(),
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bleuFonce,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Se connecter',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Application de présentation personnelle',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// PAGE PRINCIPALE ET NAVIGATION
// ==========================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<String> titles = ['Accueil', 'Mon CV', 'Ma famille', 'Contact'];

  final List<Widget> pages = const [
    HomeScreen(),
    CvScreen(),
    FamilyScreen(),
    ContactScreen(),
  ];

  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
        actions: [
          IconButton(
            tooltip: 'Déconnexion',
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: IndexedStack(index: selectedIndex, children: pages),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge),
            label: 'Mon CV',
          ),
          NavigationDestination(
            icon: Icon(Icons.family_restroom_outlined),
            selectedIcon: Icon(Icons.family_restroom),
            label: 'Famille',
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_mail_outlined),
            selectedIcon: Icon(Icons.contact_mail),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// PAGE ACCUEIL
// ==========================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 70,
                backgroundColor: Color(0xFFDCEBFA),
                child: Icon(Icons.person, size: 90, color: bleuFonce),
              ),

              const SizedBox(height: 20),

              const Text(
                'YOLOKI KEPO STEPHANIE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: bleuFonce,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Bienvenue sur mon application personnelle.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),

              const SizedBox(height: 30),

              const InfoCard(
                icon: Icons.person_outline,
                title: 'À propos de moi',
                description:
                    'Je suis YOLOKI KEPO STEPHANIE. '
                    'Bienvenue dans mon espace personnel.',
              ),

              const InfoCard(
                icon: Icons.badge_outlined,
                title: 'Mon CV',
                description:
                    'Découvrez mes informations personnelles '
                    'dans la rubrique Mon CV.',
              ),

              const InfoCard(
                icon: Icons.family_restroom,
                title: 'Ma famille',
                description:
                    'Bienvenue dans la rubrique consacrée '
                    'à ma famille.',
              ),

              const InfoCard(
                icon: Icons.contact_mail_outlined,
                title: 'Mes coordonnées',
                description:
                    'Retrouvez mes informations de contact '
                    'dans la rubrique Contact.',
              ),

              const SizedBox(height: 20),

              const Text(
                'Merci de visiter mon application !',
                textAlign: TextAlign.center,
                style: TextStyle(color: bleuFonce, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// PAGE MON CV
// ==========================================

class CvScreen extends StatelessWidget {
  const CvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFDCEBFA),
                  child: Icon(Icons.badge, size: 60, color: bleuFonce),
                ),
              ),

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  'YOLOKI KEPO STEPHANIE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: bleuFonce,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const CvSection(
                icon: Icons.person,
                title: 'Informations personnelles',
                items: [
                  'Nom : YOLOKI',
                  'Postnom : KEPO',
                  'Prénom : STEPHANIE',
                  'Adresse : Birere',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// PAGE FAMILLE
// ==========================================

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(Icons.family_restroom, size: 85, color: bleuFonce),

              const SizedBox(height: 20),

              const Text(
                'Ma famille',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: bleuFonce,
                ),
              ),

              const SizedBox(height: 15),

              Card(
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: const [
                      Icon(Icons.favorite, color: bleuClair, size: 45),
                      SizedBox(height: 15),
                      Text(
                        'Ma famille occupe une place importante '
                        'dans ma vie.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// PAGE CONTACT
// ==========================================

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> openPhone(BuildContext context) async {
    final Uri uri = Uri(scheme: 'tel', path: '0824309811');

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Impossible d’ouvrir l’application téléphone.'),
        ),
      );
    }
  }

  Future<void> openEmail(BuildContext context) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: 'stefkeps@gmail.com',
      queryParameters: {'subject': 'Prise de contact'},
    );

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Impossible d’ouvrir l’application e-mail.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(Icons.contact_mail, size: 80, color: bleuFonce),

              const SizedBox(height: 15),

              const Text(
                'Mes coordonnées',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: bleuFonce,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Vous pouvez me contacter grâce '
                'aux informations suivantes.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              ContactCard(
                icon: Icons.phone,
                title: 'Téléphone',
                value: '0824309811',
                onTap: () => openPhone(context),
              ),

              ContactCard(
                icon: Icons.email,
                title: 'Adresse e-mail',
                value: 'stefkeps@gmail.com',
                onTap: () => openEmail(context),
              ),

              const ContactCard(
                icon: Icons.location_on,
                title: 'Adresse physique',
                value: 'Birere',
              ),

              const SizedBox(height: 25),

              const Text(
                'Merci pour votre visite !',
                style: TextStyle(fontWeight: FontWeight.bold, color: bleuFonce),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// COMPOSANT CARTE D'INFORMATION
// ==========================================

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Icon(icon, color: bleuFonce, size: 35),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: bleuFonce),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(description),
        ),
      ),
    );
  }
}

// ==========================================
// COMPOSANT SECTION DU CV
// ==========================================

class CvSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> items;

  const CvSection({
    super.key,
    required this.icon,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: bleuFonce, size: 25),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: bleuFonce,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 25),

            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('• $item', style: const TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// COMPOSANT CARTE CONTACT
// ==========================================

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const ContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(15),
        leading: Icon(icon, color: bleuFonce, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: bleuFonce),
        ),
        subtitle: Text(value),
        trailing: onTap != null
            ? const Icon(Icons.open_in_new, color: bleuFonce)
            : null,
      ),
    );
  }
}
