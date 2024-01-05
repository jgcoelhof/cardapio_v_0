import 'package:flutter/material.dart';

import 'package:cardapio_v_0/server/pages/cardapio_page.dart';
import 'package:cardapio_v_0/server/pages/qrcode/adesivos_page.dart';
import 'package:cardapio_v_0/server/pages/tables_page.dart';

import '../server/pages/widget_tables.dart';

class NavBar extends StatefulWidget {
  final int count;

  const NavBar({Key? key, required this.count}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: const Color(0xFFee7b64),
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: const TextStyle(color: Color(0xFFee7b64)),
              ),
        ),
        child: BottomNavigationBar(
          fixedColor: const Color(0xFFee7b64),
          unselectedItemColor: Colors.black,
          currentIndex: _page,
          onTap: (p) {
            _pageController.animateToPage(p,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Cardápio',
              icon: Icon(Icons.menu_book),
            ),
            BottomNavigationBarItem(
              label: 'Mesas',
              icon: Icon(
                Icons.table_restaurant,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Adesivos',
              icon: Icon(
                Icons.qr_code_scanner,
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        onPageChanged: (p) {
          setState(() {
            _page = p;
          });
        },
        controller: _pageController,
        children: [
          const CardapioPage(),
          TablesPage(count: widget.count),
           AdesivosPage(count: widget.count)
        ],
      ),
    );
  }
}
