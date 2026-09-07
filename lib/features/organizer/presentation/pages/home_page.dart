import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_toolbar.dart';
import '../../../../core/widgets/status_bar.dart';
import '../../../explorer/presentation/pages/explorer_page.dart';
import '../widgets/destination_panel.dart';
import '../widgets/split_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      toolbar: AppToolbar(),
      statusBar: StatusBar(),
      body: SplitView(
        left: ExplorerPage(),
        right: DestinationPanel(),
      ),
    );
  }
}
