// Theme Provider sınıfı
import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false; //tema kontrolünü sağlayacak olan değişkenimiz

  bool get isDarkMode => _isDarkMode;

  // Temayı değiştiren fonksiyon
  void toggleTheme() {
    _isDarkMode = !_isDarkMode; //mevcuttakinin tersine döndür
    notifyListeners(); //anlık bildirilmesi için ekleriz
  }
}
