# Islamic Inheritance Calculator (Faraidh Calculator)

A comprehensive Flutter web application for calculating Islamic inheritance distribution according to Sharia law. This application provides accurate inheritance calculations with a modern, user-friendly interface supporting multiple languages.

## 🌟 Features

### Core Functionality
- **Accurate Islamic Inheritance Calculations**: Implements authentic Sharia law inheritance rules
- **Multiple Heir Types**: Supports all major categories of heirs including spouses, parents, children, siblings, grandparents, and grandchildren
- **Asset Management**: Add and manage various types of assets (house, land, car, money, gold, stocks, savings)
- **Visual Distribution**: Interactive pie chart showing inheritance distribution percentages
- **Real-time Validation**: Instant validation of heir combinations and data integrity

### User Interface
- **Modern Web-Native Design**: Clean, responsive interface optimized for web browsers
- **Material Design 3**: Latest Google Material Design principles
- **Responsive Layout**: Works seamlessly on desktop, tablet, and mobile devices
- **Intuitive Forms**: Easy-to-use forms for adding heirs and assets
- **Interactive Charts**: Beautiful pie charts powered by FL Chart library

### Internationalization
- **Multi-language Support**: English and Indonesian (Bahasa Indonesia)
- **Dynamic Language Switching**: Change language without app restart
- **Persistent Language Settings**: User's language preference is saved locally
- **Complete Localization**: All UI elements, validation messages, and heir/asset types are localized

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Chrome browser (for web development)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/faraidh_calculator.git
   cd faraidh_calculator
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run -d chrome
   ```

## 🏗️ Project Structure

```
lib/
├── bloc/                           # BLoC state management
│   ├── inheritance_bloc.dart       # Main inheritance calculation logic
│   └── inheritance_event.dart      # Events for inheritance calculations
├── blocs/                          # Additional BLoCs
│   ├── language_bloc.dart          # Language switching logic
│   ├── language_event.dart         # Language events
│   └── language_state.dart         # Language state management
├── l10n/                          # Internationalization
│   ├── app_localizations.dart      # Generated localization class
│   ├── app_localizations_en.dart   # English translations
│   ├── app_localizations_id.dart   # Indonesian translations
│   ├── app_en.arb                  # English ARB file
│   └── app_id.arb                  # Indonesian ARB file
├── models/                         # Data models
│   ├── asset.dart                  # Asset data model with localization
│   ├── heir.dart                   # Heir data model with localization
│   └── inheritance_state.dart      # Application state model
├── screens/                        # Main application screens
│   ├── home_screen.dart            # Main application screen
│   └── settings_screen.dart        # Language settings screen
├── services/                       # Business logic services
│   └── inheritance_calculator_service.dart  # Core inheritance calculation logic
├── widgets/                        # Reusable UI components
│   ├── add_asset_form.dart         # Form for adding assets
│   ├── add_heir_form.dart          # Form for adding heirs
│   ├── assets_list.dart            # List widget for assets
│   ├── heirs_list.dart             # List widget for heirs
│   ├── inheritance_pie_chart.dart  # Pie chart visualization
│   └── validation_message.dart     # Validation error display
└── main.dart                       # Application entry point
```

## 🧮 Islamic Inheritance Rules Implementation

### Supported Heir Types
- **Spouses**: Husband (Suami), Wife (Istri)
- **Parents**: Father (Ayah), Mother (Ibu)
- **Children**: Son (Anak Laki-laki), Daughter (Anak Perempuan)
- **Siblings**: Brother (Saudara Laki-laki), Sister (Saudara Perempuan)
- **Grandparents**: Grandfather (Kakek), Grandmother (Nenek)
- **Grandchildren**: Grandson (Cucu Laki-laki), Granddaughter (Cucu Perempuan)
- **Other**: For additional heir types

### Inheritance Calculation Logic
The application implements authentic Islamic inheritance rules:

1. **Fixed Shares (Fara'id)**: Certain heirs receive fixed portions
2. **Residual Inheritance ('Asabah)**: Male heirs typically receive residual amounts
3. **Gender-based Distribution**: Male heirs often receive twice the share of female heirs
4. **Hierarchical Precedence**: Closer relatives have precedence over distant ones

### Validation Rules
- Cannot have both husband and wife in the same calculation
- Must have at least one heir and one asset
- Heir names must be unique
- Asset values must be positive numbers

## 🎨 UI/UX Features

### Design Principles
- **Clean and Minimal**: Focused on functionality without clutter
- **Web-Native Feel**: Designed specifically for web browsers
- **Accessibility**: Proper contrast ratios and intuitive navigation
- **Responsive**: Adapts to different screen sizes

### Color Scheme
- **Primary Color**: Green (representing growth and prosperity)
- **Material Design 3**: Modern color system with dynamic theming
- **Semantic Colors**: Orange for warnings, red for errors, green for success

## 🌐 Internationalization

### Supported Languages
- **English**: Default language
- **Indonesian (Bahasa Indonesia)**: Complete translation

### Translation Files
- `app_en.arb`: English translations (125+ strings)
- `app_id.arb`: Indonesian translations (80+ strings)

### Language Features
- **Dynamic Switching**: Change language in settings without restart
- **Persistent Storage**: Language preference saved using SharedPreferences
- **Complete Coverage**: All UI text, validation messages, and data types localized
- **Context-aware Translation**: Models provide localized display names

## 📱 State Management

### BLoC Pattern
The application uses the BLoC (Business Logic Component) pattern for state management:

#### InheritanceBloc
- Manages heir and asset data
- Handles inheritance calculations
- Provides real-time updates

#### LanguageBloc
- Manages language preferences
- Handles language switching
- Persists language settings

### Benefits
- **Separation of Concerns**: UI and business logic are separated
- **Testability**: Business logic can be easily unit tested
- **Scalability**: Easy to add new features and states
- **Predictability**: Clear data flow and state management

## 🔧 Technical Stack

### Framework & Platform
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Web Target**: Optimized for web deployment

### Key Dependencies
```yaml
dependencies:
  flutter: sdk: flutter
  flutter_bloc: ^8.1.3          # State management
  fl_chart: ^0.68.0              # Chart visualization
  shared_preferences: ^2.2.2     # Local storage
  flutter_localizations: sdk: flutter  # Internationalization
  intl: any                      # Internationalization support

dev_dependencies:
  flutter_test: sdk: flutter
  flutter_lints: ^3.0.0
```

### Architecture Patterns
- **BLoC Pattern**: For state management
- **Repository Pattern**: For data access (if needed)
- **Widget Composition**: Modular UI components

## 🧪 Testing

### Test Categories
- **Unit Tests**: Test business logic and calculations
- **Widget Tests**: Test individual UI components
- **Integration Tests**: Test complete user workflows

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/inheritance_calculator_test.dart
```

## 🚀 Deployment

### Web Deployment
```bash
# Build for web
flutter build web

# Serve locally
flutter run -d chrome

# Deploy to hosting service
# Copy build/web/* to your web server
```

### Hosting Options
- **Firebase Hosting**: Easy deployment with GitHub integration
- **Netlify**: Simple drag-and-drop deployment
- **Vercel**: Optimized for modern web apps
- **GitHub Pages**: Free hosting for open source projects

## 🔒 Security & Privacy

### Data Handling
- **Local Storage Only**: No data sent to external servers
- **Privacy by Design**: User data remains on device
- **No Analytics**: No user tracking or data collection

### Best Practices
- Input validation and sanitization
- Secure local storage practices
- No sensitive data logging

## 🤝 Contributing

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

### Code Style
- Follow Dart/Flutter style guidelines
- Use meaningful variable and function names
- Add documentation for public APIs
- Maintain consistent formatting

### Adding New Languages
1. Create new ARB file in `lib/l10n/`
2. Add translations for all required keys
3. Update `supportedLocales` in `main.dart`
4. Generate localization files: `flutter gen-l10n`

## 📖 Islamic Law References

### Scholarly Sources
- Quran and Hadith references for inheritance laws
- Classical Islamic jurisprudence texts
- Modern scholarly interpretations

### Disclaimer
This application is for educational and assistance purposes. For official legal matters, consult qualified Islamic scholars or legal experts.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Islamic scholars who have preserved inheritance law knowledge
- Open source community for various packages used
- Contributors and testers who helped improve the application

## 📞 Support

For questions, suggestions, or issues:
- Open an issue on GitHub
- Contact the development team
- Review the documentation

---

**Developed with ❤️ using Flutter**

*May this tool help in the proper distribution of inheritance according to Islamic principles.*
