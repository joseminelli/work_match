import 'package:flutter/material.dart';
import 'job_list_screen.dart';
import 'content_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const JobListScreen(),
    const ContentScreen(),
    const ProfileScreen(),
  ];

  // Controlador para o PageView
  final PageController _pageController = PageController();

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Mudar para a página correspondente
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        currentIndex: _currentIndex,
        onTap:
            _onTabTapped, // Chama _onTabTapped para atualizar o índice e a página
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(0, Icons.work_outline_rounded, Icons.work_rounded),
            label: _currentIndex == 0 ? 'Vagas' : '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(1, Icons.video_collection_outlined,
                Icons.video_collection_rounded),
            label: _currentIndex == 1 ? 'Conteúdos' : '',
          ),
          BottomNavigationBarItem(
            icon:
                _buildIcon(2, Icons.person_2_outlined, Icons.person_2_rounded),
            label: _currentIndex == 2 ? 'Perfil' : '',
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(int index, IconData inactiveIcon, IconData activeIcon) {
    bool isSelected = _currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(isSelected ? 12.0 : 8.0),
      height: isSelected ? 47 : 20,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color.fromARGB(255, 252, 223, 195)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        isSelected ? activeIcon : inactiveIcon,
        color:
            isSelected ? const Color.fromARGB(255, 143, 87, 87) : Colors.black,
      ),
    );
  }
}
