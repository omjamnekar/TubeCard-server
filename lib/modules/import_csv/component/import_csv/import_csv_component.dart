import 'package:flutter/material.dart';

import '../../../../i18n/i18n.dart';
import '../../../../widgets/component/component.dart';
import '../../../../widgets/import/analyze_file/analyze_file_component.dart';
import '../../../../widgets/import/import_state.dart';
import '../../../../widgets/import/instructions/instructions_component.dart';
import '../../../../widgets/simple_skeleton.dart';
import '../import_overview/import_overview_component.dart';
import '../progress/progress_component.dart';
import 'import_csv_bloc.dart';
import 'import_csv_view_model.dart';

class ImportCSVComponent extends StatelessWidget {
  const ImportCSVComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Component<ImportCSVBloc>(
      createViewModel: (bloc) => bloc.createViewModel(),
      builder: (context, bloc) {
        return StreamBuilder<ImportCSVViewModel>(
          stream: bloc.viewModel,
          builder: (context, snapshot) {
            final appBarTitle = S.of(context).importCSVFile;

            switch (snapshot.data?.importState) {
              case ImportState.showInstructions:
                return InstructionsComponent(
                  appBarTitle: appBarTitle,
                  markdownBody: S.of(context).importCSVInstructionText,
                  onSelectFile: snapshot.data!.onSelectFileTap,
                );
              case ImportState.analyzeFile:
                return AnalyzeFileComponent(
                  appBarTitle: appBarTitle,
                  filePath: snapshot.data!.filePath!,
                  analyzeFile: snapshot.data!.analyzeFile,
                  onOpenEmailAppTap: snapshot.data!.onOpenEmailAppTap,
                );
              case ImportState.showDataOverview:
                return DataOverviewComponent(
                  appBarTitle: appBarTitle,
                  deck: snapshot.data!.importDeck!,
                  importOverviewCallback: snapshot.data!.importOverviewCallback,
                );
              case ImportState.showProgress:
                return ProgressComponent(
                  appBarTitle: appBarTitle,
                  deck: snapshot.data!.importDeck!,
                  onOpenEmailAppTap: snapshot.data!.onOpenEmailAppTap,
                );
              default:
                return SimpleSkeleton(appBarTitle: appBarTitle);
            }
          },
        );
      },
    );
  }
}
