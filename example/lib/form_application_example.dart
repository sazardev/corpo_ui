import 'package:corpo_ui/corpo_ui.dart';
import 'package:flutter/material.dart';

/// Form-Heavy Application Example showcasing comprehensive form patterns.
///
/// This example demonstrates advanced form handling including:
/// - Multi-step forms with validation
/// - Complex input components
/// - Form state management
/// - Validation patterns
/// - Accessibility features
class FormApplicationExample extends StatelessWidget {
  const FormApplicationExample({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Form Application Example',
      theme: CorpoTheme.light(),
      darkTheme: CorpoTheme.dark(),
      home: const FormHomePage(),
    );
}

/// Main page showcasing different form patterns.
class FormHomePage extends StatelessWidget {
  const FormHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Form Examples'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Card(
            child: ListTile(
              title: const Text('User Registration Form'),
              subtitle: const Text('Multi-step registration with validation'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const UserRegistrationForm(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: const Text('Contact Information Form'),
              subtitle: const Text('Complex form with various input types'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const ContactInformationForm(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: const Text('Survey Form'),
              subtitle: const Text('Dynamic form with conditional fields'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => const SurveyForm()),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: const Text('Settings Form'),
              subtitle: const Text('Preferences and configuration form'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => const SettingsForm()),
              ),
            ),
          ),
        ],
      ),
    );
}

/// Multi-step user registration form.
class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({super.key});

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _currentStep = 0;
  final int _totalSteps = 3;

  // Form data
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';
  String _company = '';
  String _jobTitle = '';
  bool _termsAccepted = false;
  bool _marketingOptIn = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / _totalSteps,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              _currentStep = index;
            });
          },
          children: <Widget>[
            _buildPersonalInfoStep(),
            _buildAccountStep(),
            _buildCompanyStep(),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );

  Widget _buildPersonalInfoStep() => SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Personal Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Step ${_currentStep + 1} of $_totalSteps',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'First Name',
              hintText: 'Enter your first name',
            ),
            validator: (String? value) => value?.isEmpty == true ? 'Required' : null,
            onSaved: (String? value) => _firstName = value ?? '',
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Last Name',
              hintText: 'Enter your last name',
            ),
            validator: (String? value) => value?.isEmpty == true ? 'Required' : null,
            onSaved: (String? value) => _lastName = value ?? '',
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter your email',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            onSaved: (String? value) => _email = value ?? '',
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
            ),
            keyboardType: TextInputType.phone,
            onSaved: (String? value) => _phone = value ?? '',
          ),
        ],
      ),
    );

  Widget _buildAccountStep() => SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Account Setup',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Step ${_currentStep + 1} of $_totalSteps',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter a secure password',
              helperText: 'Minimum 8 characters',
            ),
            obscureText: true,
            validator: _validatePassword,
            onSaved: (String? value) {
              // Password saved for validation
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
            ),
            obscureText: true,
            validator: _validateConfirmPassword,
            onSaved: (String? value) {
              // Confirm password saved for validation
            },
          ),
          const SizedBox(height: 24),
          CheckboxListTile(
            title: const Text('Accept Terms and Conditions'),
            subtitle: const Text(
              'I agree to the terms of service and privacy policy',
            ),
            value: _termsAccepted,
            onChanged: (bool? value) {
              setState(() {
                _termsAccepted = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Marketing Communications'),
            subtitle: const Text('Receive updates and promotional emails'),
            value: _marketingOptIn,
            onChanged: (bool? value) {
              setState(() {
                _marketingOptIn = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    );

  Widget _buildCompanyStep() => SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Company Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Step ${_currentStep + 1} of $_totalSteps',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Company Name',
              hintText: 'Enter your company name',
            ),
            onSaved: (String? value) => _company = value ?? '',
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Job Title',
              hintText: 'Enter your job title',
            ),
            onSaved: (String? value) => _jobTitle = value ?? '',
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Registration Summary',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text('Please review your information before submitting.'),
                  const SizedBox(height: 16),
                  if (_currentStep == _totalSteps - 1) ...<Widget>[
                    Text('Name: $_firstName $_lastName'),
                    Text('Email: $_email'),
                    if (_phone.isNotEmpty) Text('Phone: $_phone'),
                    if (_company.isNotEmpty) Text('Company: $_company'),
                    if (_jobTitle.isNotEmpty) Text('Title: $_jobTitle'),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );

  Widget _buildNavigationBar() => Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                child: const Text('Previous'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _canProceed() ? _nextStep : null,
              child: Text(_currentStep == _totalSteps - 1 ? 'Submit' : 'Next'),
            ),
          ),
        ],
      ),
    );

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return true; // Basic validation handled by form
      case 1:
        return _termsAccepted;
      case 2:
        return true;
      default:
        return false;
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _submitForm();
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('Your account has been created successfully!'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value?.isEmpty == true) return 'Email is required';
    if (!value!.contains('@')) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value?.isEmpty == true) return 'Password is required';
    if (value!.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value?.isEmpty == true) return 'Please confirm your password';
    // Note: In a real app, you'd compare with the actual password field value
    return null;
  }
}

/// Contact information form with various input types.
class ContactInformationForm extends StatefulWidget {
  const ContactInformationForm({super.key});

  @override
  State<ContactInformationForm> createState() => _ContactInformationFormState();
}

class _ContactInformationFormState extends State<ContactInformationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedCountry = 'United States';
  String _selectedCategory = 'General';
  bool _urgentRequest = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Contact Information')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Contact Form',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (String? value) =>
                    value?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) =>
                    value?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Country',
                  prefixIcon: Icon(Icons.public),
                ),
                initialValue: _selectedCountry,
                items:
                    <String>['United States', 'Canada', 'United Kingdom', 'Australia']
                        .map(
                          (String country) => DropdownMenuItem(
                            value: country,
                            child: Text(country),
                          ),
                        )
                        .toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedCountry = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Icons.category),
                ),
                initialValue: _selectedCategory,
                items: <String>['General', 'Support', 'Sales', 'Feedback', 'Bug Report']
                    .map(
                      (String category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  prefixIcon: Icon(Icons.subject),
                ),
                validator: (String? value) =>
                    value?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Message',
                  prefixIcon: Icon(Icons.message),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (String? value) =>
                    value?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Urgent Request'),
                subtitle: const Text('Mark this as high priority'),
                value: _urgentRequest,
                onChanged: (bool value) {
                  setState(() {
                    _urgentRequest = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Send Message'),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Message Sent'),
          content: const Text(
            'Thank you for your message. We\'ll get back to you soon!',
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

/// Dynamic survey form with conditional fields.
class SurveyForm extends StatefulWidget {
  const SurveyForm({super.key});

  @override
  State<SurveyForm> createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  String? _satisfaction;
  String? _recommendation;
  bool _showAdditionalQuestions = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Survey Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Customer Satisfaction Survey',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('How satisfied are you with our service?'),
                    const SizedBox(height: 8),
                    ...<String>[
                          'Very Satisfied',
                          'Satisfied',
                          'Neutral',
                          'Dissatisfied',
                          'Very Dissatisfied',
                        ]
                        .map(
                          (String option) => RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: _satisfaction,
                            onChanged: (String? value) {
                              setState(() {
                                _satisfaction = value;
                                _showAdditionalQuestions =
                                    value == 'Dissatisfied' ||
                                    value == 'Very Dissatisfied';
                              });
                            },
                          ),
                        )
                        ,
                  ],
                ),
              ),
            ),
            if (_showAdditionalQuestions) ...<Widget>[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('What can we improve?'),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Additional Comments',
                          hintText: 'Please tell us how we can improve...',
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Would you recommend us to others?'),
                    const SizedBox(height: 8),
                    ...<String>[
                          'Definitely',
                          'Probably',
                          'Not Sure',
                          'Probably Not',
                          'Definitely Not',
                        ]
                        .map(
                          (String option) => RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: _recommendation,
                            onChanged: (String? value) {
                              setState(() {
                                _recommendation = value;
                              });
                            },
                          ),
                        )
                        ,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitSurvey,
                child: const Text('Submit Survey'),
              ),
            ),
          ],
        ),
      ),
    );

  void _submitSurvey() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Survey Submitted'),
        content: const Text('Thank you for your feedback!'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// Settings form with preferences.
class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  bool _notifications = true;
  bool _emailUpdates = false;
  bool _darkMode = false;
  double _fontSize = 16;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: <Widget>[
          TextButton(onPressed: _saveSettings, child: const Text('Save')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Notifications'),
                  subtitle: const Text('Enable push notifications'),
                  trailing: Switch(
                    value: _notifications,
                    onChanged: (bool value) {
                      setState(() {
                        _notifications = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Email Updates'),
                  subtitle: const Text('Receive email notifications'),
                  trailing: Switch(
                    value: _emailUpdates,
                    onChanged: (bool value) {
                      setState(() {
                        _emailUpdates = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Use dark color theme'),
                  trailing: Switch(
                    value: _darkMode,
                    onChanged: (bool value) {
                      setState(() {
                        _darkMode = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Font Size: ${_fontSize.toInt()}px',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Slider(
                    value: _fontSize,
                    min: 12,
                    max: 24,
                    divisions: 6,
                    onChanged: (double value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved successfully')),
    );
  }
}

/// Entry point for the form application example.
void main() {
  runApp(const FormApplicationExample());
}
