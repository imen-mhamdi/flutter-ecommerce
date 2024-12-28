// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class AddPaymentMethod extends StatefulWidget {
//   @override
//   _AddPaymentMethodState createState() => _AddPaymentMethodState();
// }

// class _AddPaymentMethodState extends State<AddPaymentMethod> {
//   final _formKey = GlobalKey<FormState>();
//   final _cardNumberController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//   final _cvvController = TextEditingController();

//   String _formattedCardNumber = "XXXX XXXX XXXX XXXX";
//   String _formattedExpiryDate = "MM/YY";

//   @override
//   void initState() {
//     super.initState();
//     _cardNumberController.addListener(_updateCardPreview);
//     _expiryDateController.addListener(_updateCardPreview);
//   }

//   @override
//   void dispose() {
//     _cardNumberController.removeListener(_updateCardPreview);
//     _expiryDateController.removeListener(_updateCardPreview);
//     _cardNumberController.dispose();
//     _expiryDateController.dispose();
//     _cvvController.dispose();
//     super.dispose();
//   }

//   void _updateCardPreview() {
//     setState(() {
//       _formattedCardNumber = _cardNumberController.text.isEmpty
//           ? "XXXX XXXX XXXX XXXX"
//           : formatCardNumber(_cardNumberController.text);

//       _formattedExpiryDate = _expiryDateController.text.isEmpty
//           ? "MM/YY"
//           : _expiryDateController.text;
//     });
//   }

//   String formatCardNumber(String input) {
//     return input
//         .replaceAllMapped(RegExp(r".{1,4}"), (match) => "${match.group(0)} ")
//         .trimRight();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Add Payment Method",
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 1,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Aperçu de la cart
//                 CardPreview(
//                   cardNumber: _formattedCardNumber,
//                   expiryDate: _formattedExpiryDate,
//                 ),
//                 SizedBox(height: 24),

//                 InputField(
//                   controller: _cardNumberController,
//                   hintText: "XXXX XXXX XXXX XXXX",
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(16),
//                     TextInputFormatter.withFunction((oldValue, newValue) {
//                       final formatted = formatCardNumber(newValue.text);
//                       return TextEditingValue(
//                         text: formatted,
//                         selection:
//                             TextSelection.collapsed(offset: formatted.length),
//                       );
//                     }),
//                   ],
//                   validator: (value) {
//                     if (value == null || value.isEmpty || value.length != 19) {
//                       return 'Invalid card number';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16),

//                 Row(
//                   children: [
//                     Expanded(
//                       child: InputField(
//                         controller: _expiryDateController,
//                         hintText: "MM/YY",
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           LengthLimitingTextInputFormatter(4),
//                           TextInputFormatter.withFunction((oldValue, newValue) {
//                             String text = newValue.text;
//                             if (text.length >= 2) {
//                               text =
//                                   "${text.substring(0, 2)}/${text.substring(2)}";
//                             }
//                             return TextEditingValue(
//                               text: text,
//                               selection:
//                                   TextSelection.collapsed(offset: text.length),
//                             );
//                           }),
//                         ],
//                         validator: (value) {
//                           if (value == null ||
//                               value.isEmpty ||
//                               !RegExp(r"^(0[1-9]|1[0-2])\/\d{2}$")
//                                   .hasMatch(value)) {
//                             return 'Invalid expiry date';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     Expanded(
//                       child: InputField(
//                         controller: _cvvController,
//                         hintText: "CVV",
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           LengthLimitingTextInputFormatter(3),
//                         ],
//                         validator: (value) {
//                           if (value == null ||
//                               value.isEmpty ||
//                               value.length != 3) {
//                             return 'Invalid CVV';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24),
//                 // Bouton
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content: Text('Payment method added successfully')),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: FittedBox(
//                     child: Text(
//                       "ADD PAYMENT METHOD",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CardPreview extends StatelessWidget {
//   final String cardNumber;
//   final String expiryDate;

//   const CardPreview({required this.cardNumber, required this.expiryDate});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 8,
//               spreadRadius: 2),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//               top: 16,
//               left: 16,
//               child: Text("Mono Bank",
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold))),
//           Positioned(
//               bottom: 60,
//               left: 16,
//               child: Text(cardNumber,
//                   style: TextStyle(
//                       color: Colors.white, fontSize: 18, letterSpacing: 2))),
//           Positioned(
//               bottom: 30,
//               left: 16,
//               child: Text(expiryDate,
//                   style: TextStyle(color: Colors.white, fontSize: 16))),
//         ],
//       ),
//     );
//   }
// }

// class InputField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final TextInputType keyboardType;
//   final List<TextInputFormatter>? inputFormatters;
//   final FormFieldValidator<String>? validator;

//   const InputField({
//     required this.controller,
//     required this.hintText,
//     required this.keyboardType,
//     this.inputFormatters,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       inputFormatters: inputFormatters,
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: OutlineInputBorder(),
//       ),
//       validator: validator,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/views/screen/add_address_screen.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({super.key});

  @override
  _AddPaymentMethodState createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  String _formattedCardNumber = "XXXX XXXX XXXX XXXX";
  String _formattedExpiryDate = "MM/YY";

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_updateCardPreview);
    _expiryDateController.addListener(_updateCardPreview);
  }

  @override
  void dispose() {
    _cardNumberController.removeListener(_updateCardPreview);
    _expiryDateController.removeListener(_updateCardPreview);
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _updateCardPreview() {
    setState(() {
      _formattedCardNumber = _cardNumberController.text.isEmpty
          ? "XXXX XXXX XXXX XXXX"
          : formatCardNumber(_cardNumberController.text);

      _formattedExpiryDate = _expiryDateController.text.isEmpty
          ? "MM/YY"
          : _expiryDateController.text;
    });
  }

  String formatCardNumber(String input) {
    return input
        .replaceAllMapped(RegExp(r".{1,4}"), (match) => "${match.group(0)} ")
        .trimRight();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Add Payment Method",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardPreview(
                  cardNumber: _formattedCardNumber,
                  expiryDate: _formattedExpiryDate,
                ),
                const SizedBox(height: 24),
                InputField(
                  controller: _cardNumberController,
                  hintText: "XXXX XXXX XXXX XXXX",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final formatted = formatCardNumber(newValue.text);
                      return TextEditingValue(
                        text: formatted,
                        selection:
                            TextSelection.collapsed(offset: formatted.length),
                      );
                    }),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 19) {
                      return 'Invalid card number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        controller: _expiryDateController,
                        hintText: "MM/YY",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            String text = newValue.text;
                            if (text.length >= 2) {
                              text =
                                  "${text.substring(0, 2)}/${text.substring(2)}";
                            }
                            return TextEditingValue(
                              text: text,
                              selection:
                                  TextSelection.collapsed(offset: text.length),
                            );
                          }),
                        ],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(r"^(0[1-9]|1[0-2])\/\d{2}$")
                                  .hasMatch(value)) {
                            return 'Invalid expiry date';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputField(
                        controller: _cvvController,
                        hintText: "CVV",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 3) {
                            return 'Invalid CVV';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigate to a new page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAddressScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const FittedBox(
                    child: Text(
                      "ADD PAYMENT METHOD",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardPreview extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;

  const CardPreview(
      {super.key, required this.cardNumber, required this.expiryDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
              top: 16,
              left: 16,
              child: Text("Mono Bank",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          Positioned(
              bottom: 60,
              left: 16,
              child: Text(cardNumber,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 18, letterSpacing: 2))),
          Positioned(
              bottom: 30,
              left: 16,
              child: Text(expiryDate,
                  style: const TextStyle(color: Colors.white, fontSize: 16))),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;

  const InputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Success"),
      ),
      body: const Center(
        child: Text(
          "Payment method added successfully!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
