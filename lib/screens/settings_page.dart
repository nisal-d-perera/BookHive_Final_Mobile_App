import 'package:bookhive/data/card_data.dart';
import 'package:bookhive/data/address_data.dart';
import 'package:bookhive/data/user_data.dart';
import 'package:bookhive/helper/appcolors.dart';
import 'package:bookhive/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookhive/models/user_model.dart';
import 'package:bookhive/models/address_model.dart';
import 'package:bookhive/models/card_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Settings',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Account Settings',
                style: TextStyle(color: Colors.black, fontSize: 18)),
            subtitle: const Text('Privacy, Security, Language'),
            leading: const Icon(
              Icons.person,
              color: AppColors.mainColor,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          //Shipping Address
          ListTile(
            title: const Text('Shipping Address',
                style: TextStyle(color: Colors.black, fontSize: 18)),
            subtitle: const Text('Manage your shipping addresses'),
            leading: const Icon(
              Icons.location_on,
              color: AppColors.mainColor,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ShippingAddressPage(),
                ),
              );
            },
          ),
          //Payment Method
          ListTile(
            title: const Text('Payment Method',
                style: TextStyle(color: Colors.black, fontSize: 18)),
            subtitle: const Text('Manage your Payment Method'),
            leading: const Icon(
              Icons.payment,
              color: AppColors.mainColor,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MyCardsPage(),
                ),
              );
            },
          ),
          //Term & Condition
          ListTile(
            title: const Text('Terms & Conditions ',
                style: TextStyle(color: Colors.black, fontSize: 18)),
            subtitle: const Text('Company terms and conditions'),
            leading: const Icon(
              Icons.library_books,
              color: AppColors.mainColor,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TermAndConditionPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('About Us  ',
                style: TextStyle(color: Colors.black, fontSize: 18)),
            subtitle: const Text('Learn more about BookHive'),
            leading: const Icon(
              Icons.info_outline,
              color: AppColors.mainColor,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutUsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Logout',
                style: TextStyle(color: Colors.black, fontSize: 18)),
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LogoutPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: AppColors.mainColor,
          title: Text(
            'Account Settings',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView(
            children: <Widget>[
              buildPrivacy(context),
              buildSecurity(context),
              buildAccountInfo(context),
              buildLanguage(),
            ],
          ),
        ));
  }

  Widget buildPrivacy(BuildContext context) {
    return ListTile(
      title: const Text('Privacy',
          style: TextStyle(color: Colors.black, fontSize: 18)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PrivacyPage()),
        );
      },
    );
  }

  Widget buildSecurity(BuildContext context) {
    return ListTile(
      title: const Text('Security',
          style: TextStyle(color: Colors.black, fontSize: 18)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SecurityPage()),
        );
      },
    );
  }

  Widget buildAccountInfo(BuildContext context) {
    return ListTile(
      title: const Text('Account Information',
          style: TextStyle(color: Colors.black, fontSize: 18)),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AccountInformationPage(),
          ),
        );
      },
    );
  }

  //Language
  Widget buildLanguage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<int>(
        decoration: const InputDecoration(
          labelText: 'Language',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow),
          ),
        ),
        value: 1,
        items: const [
          DropdownMenuItem(value: 1, child: Text('English')),
          DropdownMenuItem(value: 2, child: Text('Spanish')),
          DropdownMenuItem(value: 3, child: Text('Hindi')),
          DropdownMenuItem(value: 4, child: Text('Chinese')),
        ],
        onChanged: (language) {
          // Handle language change
          print('Language changed to: $language');
        },
      ),
    );
  }
}

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  int? userId;
  User? userDetail;
  Address? userAddress;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user_id');
    });
    if (userId != null) {
      setState(() {
        userDetail = userdetails.firstWhere(
          (user) => user.id == userId,
        );

        userAddress = addressdetails.firstWhere(
          (address) => address.userId == userId,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Shipping Address',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: userId == null
          ? const Center(child: CircularProgressIndicator())
          : userDetail == null || userAddress == null
              ? const Center(child: Text('No shipping address available'))
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Default',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.grey),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${userDetail!.name}, ${userDetail!.mobile}\n'
                                  '${userAddress!.address}, ${userAddress!.city},\n'
                                  '${userAddress!.district}, ${userAddress!.province},\n'
                                  '${userAddress!.postalCode}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              // Handle Edit action
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddAddress(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Add new address',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}

// Shipping Address
class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Add Shipping Address',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ShippingAddressForm(),
      ),
    );
  }
}

class ShippingAddressForm extends StatefulWidget {
  const ShippingAddressForm({super.key});

  @override
  _ShippingAddressFormState createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          // Name field
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Address field
          TextFormField(
            controller: addressController,
            decoration: const InputDecoration(
              labelText: 'Street Address',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // City field
          TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your city';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // State field
          TextFormField(
            controller: stateController,
            decoration: const InputDecoration(
              labelText: 'State',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your state';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Postal code field
          TextFormField(
            controller: postalCodeController,
            decoration: const InputDecoration(
              labelText: 'Postal Code',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your postal code';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Phone number field
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Submit button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Handle form submission
                print('Name: ${nameController.text}');
                print('Address: ${addressController.text}');
                print('City: ${cityController.text}');
                print('State: ${stateController.text}');
                print('Postal Code: ${postalCodeController.text}');
                print('Phone: ${phoneController.text}');
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  int? userId;
  List<Cards> userCards = []; // Updated to a list

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user_id');
    });

    if (userId != null) {
      setState(() {
        // Filter cards belonging to the user
        userCards =
            carddetails.where((cards) => cards.userId == userId).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'My Cards',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Check if userCards is empty
            if (userCards.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'No cards available. Add a new card.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userCards.length,
                itemBuilder: (context, index) {
                  final card = userCards[index];
                  return Card(
                    margin: const EdgeInsets.all(16.0),
                    elevation: 1,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: Icon(
                        card.cardType == 'Visa'
                            ? Icons.credit_card
                            : Icons.payment,
                        color: Colors.grey,
                        size: 40,
                      ),
                      title: Text(
                        card.cardType,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '**** ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          // More actions for card
                        },
                      ),
                    ),
                  );
                },
              ),
            // Add new card section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PaymentForm(),
                    ),
                  );
                },
                leading:
                    const Icon(Icons.add_circle_outline, color: Colors.grey),
                title: const Text(
                  'Add new card',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            // Information section
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.green.shade50,
              child: Row(
                children: const [
                  Icon(Icons.security, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your information is safe with us',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Payment Method
class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nameOnCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Add Payment Method',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Card Number
              TextFormField(
                controller: cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  } else if (value.length < 16 || value.length > 16) {
                    return 'Card number must be 16 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Expiry Date
              TextFormField(
                controller: expiryDateController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expiry date';
                  } else if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$')
                      .hasMatch(value)) {
                    return 'Enter a valid expiry date (MM/YY)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // CVV
              TextFormField(
                controller: cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the CVV';
                  } else if (value.length != 3) {
                    return 'CVV must be 3 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Name on Card
              TextFormField(
                controller: nameOnCardController,
                decoration: const InputDecoration(
                  labelText: 'Name on Card',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name on the card';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _processPayment();
                  }
                },
                child: const Text('Submit Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processPayment() {
    // Handle the payment logic here
    print('Processing payment...');
    print('Card Number: ${cardNumberController.text}');
    print('Expiry Date: ${expiryDateController.text}');
    print('CVV: ${cvvController.text}');
    print('Name on Card: ${nameOnCardController.text}');

    // Navigate to a success or failure page
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Successful'),
        content: const Text('Your payment has been processed successfully!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

//Account Information
class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({super.key});

  @override
  State<AccountInformationPage> createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  int? userId;
  String? userImage;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userGender;
  String? userBirthday;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user_id');
    });
    if (userId != null) {
      User? user = userdetails.firstWhere(
        (user) => user.id == userId,
      );
      setState(() {
        userImage = user.image;
        userName = user.name;
        userEmail = user.email;
        userPhone = user.mobile;
        userGender = user.gender;
        userBirthday = user.birthday;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Account Information',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Picture Section
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/$userImage'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: AppColors.mainColor),
                      onPressed: () {
                        // Handle profile picture edit
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Name Field
            buildAccountInfoTile(
              context,
              icon: Icons.person,
              title: 'Name',
              subtitle: userName ?? '',
              onTap: () {
                // Handle edit name
              },
            ),
            const Divider(),

            // Email Field
            buildAccountInfoTile(
              context,
              icon: Icons.email,
              title: 'Email',
              subtitle: userEmail ?? '',
              onTap: () {
                // Handle edit email
              },
            ),
            const Divider(),

            // Phone Number Field
            buildAccountInfoTile(
              context,
              icon: Icons.phone,
              title: 'Phone Number',
              subtitle: userPhone ?? '',
              onTap: () {
                // Handle edit phone number
              },
            ),
            const Divider(),

            // Address Field
            buildAccountInfoTile(
              context,
              icon: Icons.person_pin,
              title: 'Gender',
              subtitle: userGender ?? '',
              onTap: () {
                // Handle edit address
              },
            ),
            const Divider(),
            buildAccountInfoTile(
              context,
              icon: Icons.cake,
              title: 'Birthday',
              subtitle: userBirthday ?? '',
              onTap: () {
                // Handle edit address
              },
            ),
        
          ],
        ),
      ),
    );
  }

  Widget buildAccountInfoTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.edit),
      onTap: onTap,
    );
  }

}

//Security Page
class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Security Settings',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Change Password
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              onTap: () {
                // Handle change password functionality
              },
            ),
            const Divider(),

            // Two-Factor Authentication
            ListTile(
              leading: const Icon(Icons.shield),
              title: const Text('Two-Factor Authentication',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              onTap: () {
                // Handle two-factor authentication setup
              },
            ),
            const Divider(),

            // App Lock
            ListTile(
              leading: const Icon(Icons.phonelink_lock),
              title: const Text('App Lock',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              onTap: () {
                // Handle app lock settings
              },
            ),
            const Divider(),

            // Security Tips
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Security Tips',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              onTap: () {
                // Handle navigation to security tips
              },
            ),
          ],
        ),
      ),
    );
  }
}

//Privacy Page
class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Privacy Settings',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Manage Permissions
            ListTile(
              leading: const Icon(Icons.lock_open),
              title: const Text('Manage Permissions',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              onTap: () {
                // Handle manage permissions functionality
              },
            ),
            const Divider(),

            // Data Sharing
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Data Sharing Preferences',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              onTap: () {
                // Handle data sharing preferences functionality
              },
            ),
            const Divider(),

            // Delete Account
            ListTile(
              leading: const Icon(Icons.delete_forever),
              title: const Text('Delete Account',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              onTap: () {
                // Handle account deletion functionality
              },
            ),
            const Divider(),

            // Privacy Policy
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Privacy Policy',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              onTap: () {
                // Handle navigation to privacy policy
              },
            ),
          ],
        ),
      ),
    );
  }
}

//TermAndConditionPage
class TermAndConditionPage extends StatelessWidget {
  const TermAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '1. Introduction\n\n'
                'These Terms and Conditions govern the use of this application. By using the app, you agree to these terms.\n\n'
                '2. User Responsibilities\n\n'
                'You are responsible for maintaining the confidentiality of your account information and for all activities under your account.\n\n'
                '3. Privacy Policy\n\n'
                'We value your privacy. Please refer to our Privacy Policy for more details on how we collect, store, and use your data.\n\n'
                '4. Limitations of Liability\n\n'
                'We are not responsible for any damages or losses caused by the use of this application.\n\n'
                '5. Termination\n\n'
                'We may terminate your access to the app at any time for any reason.\n\n'
                '6. Governing Law\n\n'
                'These terms are governed by the laws of the country in which this app is operated.\n\n'
                '7. Changes to Terms\n\n'
                'We may update these terms from time to time. Please check this page regularly for any updates.\n\n'
                '8. Contact Us\n\n'
                'If you have any questions about these Terms and Conditions, please contact us at support@example.com.\n\n',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Optional: Handle the acceptance of terms if required
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Terms Accepted'),
                        content: const Text(
                            'You have accepted the Terms and Conditions.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage())); // Close the dialog
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text('I Accept',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

//About Us
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'About BookHive',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to BookHive!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'BookHive is your trusted online bookstore where readers, students, and professionals can find a diverse collection of books. From academic resources to the latest bestsellers, we cater to all your reading needs. Our mission is to make books accessible to everyone through affordable pricing and convenient shopping experiences.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Why Choose Us?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Wide range of books for all ages and interests.\n'
              '• Affordable prices with regular discounts.\n'
              '• Simple and secure purchasing process.\n'
              '• Reliable delivery services to your doorstep.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.web, color: AppColors.mainColor),
                    const SizedBox(width: 8),
                    Text('Web: https://bookhive.com',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.email, color: AppColors.mainColor),
                    const SizedBox(width: 8),
                    Text('Email: info@bookhive.com',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.phone, color: AppColors.mainColor),
                    const SizedBox(width: 8),
                    Text('Phone: +94112234567', style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: AppColors.mainColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Location: 123 Main Street, Colombo, Sri Lanka',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Go Back',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Center content vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.logout,
                size: 100,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Are you sure you want to log out?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                child: const Text('No, Stay Logged In'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                child: const Text('Yes, Log Out',
                    style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
