import 'package:cypher_system_srd_lookup/db/bookmark.db.dart';
import 'package:cypher_system_srd_lookup/events/event_handler.dart';
import 'package:cypher_system_srd_lookup/json_data/json_types.dart';
import 'package:cypher_system_srd_lookup/pages/page_bookmarks.dart';
import 'package:cypher_system_srd_lookup/pages/page_browse.dart';
import 'package:cypher_system_srd_lookup/pages/page_search.dart';
import 'package:cypher_system_srd_lookup/search/full_entry.dart';
import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CRouterConfig {
  final GoRouter config;
  final CJsonRoot dataRoot;

  CRouterConfig({required this.dataRoot})
      : config = GoRouter(
          routes: [
            ShellRoute(
              builder: (context, state, child) => CAppShell(
                dataRoot: dataRoot,
                child: child,
              ),
              routes: [
                GoRoute(
                  path: '/',
                  redirect: (context, state) => '/search',
                ),
                GoRoute(
                  path: '/search',
                  builder: (context, state) =>
                      const CPageShell(child: CPageSearch()),
                ),
                GoRoute(
                  path: '/bookmarks',
                  builder: (context, state) =>
                      const CPageShell(child: CPageBookmarks()),
                ),
                GoRoute(
                  path: '/browse',
                  builder: (context, state) =>
                      const CPageShell(child: CPageBrowse()),
                ),
              ],
            )
          ],
        );
}

class CAppShell extends StatelessWidget {
  final Widget child;
  final CJsonRoot dataRoot;
  final CSearchManager searchManager;
  late final CEventHandler eventHandler;

  CAppShell({
    super.key,
    required this.dataRoot,
    required this.child,
  }) : searchManager = CSearchManager(dataRoot) {
    eventHandler = CEventHandler(searchManager: searchManager);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CEventHandler>(
          create: (_) => eventHandler,
        ),
        ChangeNotifierProvider<CSearchManager>(
          create: (_) => searchManager,
        ),
        ChangeNotifierProvider<CBookmarkManager>(
          create: (_) => CBookmarkManager(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: _Navbar(),
        endDrawer: Consumer<CSearchManager>(
          builder: (_, searchManager, __) => Drawer(
            child: searchManager.selectedResult != null
                ? SafeArea(
                    child: CFullEntry(
                      result: searchManager.selectedResult!,
                    ),
                  )
                : null,
          ),
        ),
        body: child,
      ),
    );
  }
}

class _Navbar extends StatefulWidget {
  @override
  State<_Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<_Navbar> {
  final List<(NavigationDestination, String)> _navItemRoutes = [
    (
      const NavigationDestination(icon: Icon(Icons.search), label: "Search"),
      "/search"
    ),
    (
      const NavigationDestination(
          icon: Icon(Icons.bookmark), label: "Bookmarks"),
      '/bookmarks'
    ),
    (
      const NavigationDestination(icon: Icon(Icons.view_list), label: "Browse"),
      '/browse'
    ),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (ix) => setState(() {
        selectedIndex = ix;
        context.go(_navItemRoutes[ix].$2);
      }),
      destinations: _navItemRoutes.map((r) => r.$1).toList(),
    );
  }
}

class CPageShell extends StatelessWidget {
  final Widget child;

  const CPageShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SizedBox.expand(
        child: SafeArea(child: child),
      ),
    );
  }
}
