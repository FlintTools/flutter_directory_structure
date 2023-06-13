import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class BaseViewmodel extends GetxController {

  late BuildContext context;
  bool isLoading = false;

  setLoading(bool status){
    isLoading = status;
    update();
  }


  runDisplayInfoBar({
    String title = "",
    String content = "",
    Alignment alignment = Alignment.topRight,
    Duration duration = const Duration(seconds: 5),
    InfoBarSeverity severity = InfoBarSeverity.error,
  }) {
    displayInfoBar(
      context,
      alignment:alignment,
      duration: duration,
      builder: (context, close) {
        return InfoBar(
          title:  Text(title),
          content: Text(content),
          action: IconButton(
            icon: const Icon(FluentIcons.clear),
            onPressed: close,
          ),
          severity: severity,
        );
      },
    );
  }
}
