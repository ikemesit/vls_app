import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

class DonationsPage extends StatelessWidget {
  const DonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donations'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://media.istockphoto.com/id/1927599210/photo/paramaribo-surinam.jpg?s=612x612&w=0&k=20&c=FN56QKvHGEtW2sgtGPkzZw3hh2fecG5TdrW5i3aRt7k=",
              width: double.infinity,
              height: 300.0,
              fit: BoxFit.cover,
              progressIndicatorBuilder:
                  (context, url, progress) => Center(
                    child: CircularProgressIndicator(value: progress.progress),
                  ),
            ),
            Gap(15.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Card(
                      color: TColors.primary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Donate to support our cause",
                              style: TTextTheme.darkTextTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                    height: 1.0,
                                  ),
                            ),
                          ),
                          Gap(10.0),
                          Container(
                            color: TColors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Join us in supporting our cause. Let's make a difference together!",
                                    style: TTextTheme.lightTextTheme.bodyMedium,
                                  ),
                                  Gap(20.0),
                                  Divider(
                                    color: TColors.borderPrimary,
                                    thickness: 1.0,
                                    height: 50.0,
                                  ),
                                  Gap(20.0),
                                  Text(
                                    "All donations should be made to the following account:",
                                    style: TTextTheme.lightTextTheme.bodyMedium,
                                  ),
                                  Gap(10.0),
                                  Text(
                                    "Account Name: VLS Charity",
                                    style: TTextTheme.lightTextTheme.bodyMedium,
                                  ),
                                  Gap(10.0),
                                  Text(
                                    "Account Number: 1234567890",
                                    style: TTextTheme.lightTextTheme.bodyMedium,
                                  ),
                                  Gap(10.0),
                                  Text(
                                    "Bank: Bank of America",
                                    style: TTextTheme.lightTextTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

  // Widget _buildDonationOptions(
  //   BuildContext context,
  //   DonationProvider provider,
  // ) {
  //   final TextEditingController amountController = TextEditingController();
  //   final TextEditingController descriptionController = TextEditingController();

  //   return C(
  //     color: TColors.white,
  //     margin: EdgeInsets.all(16),
  //     child: Padding(
  //       padding: EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Join us in supporting our cause. Let\'s make a difference together!',
  //             style: TTextTheme.lightTextTheme.headlineMedium,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

//   void _processDonation(
//     BuildContext context,
//     DonationProvider provider,
//     TextEditingController amountController,
//     TextEditingController descriptionController,
//     double presetAmount,
//   ) {
//     amountController.text = presetAmount.toString();
//     _processCustomDonation(
//       context,
//       provider,
//       amountController,
//       descriptionController,
//     );
//   }

//   void _processCustomDonation(
//     BuildContext context,
//     DonationProvider provider,
//     TextEditingController amountController,
//     TextEditingController descriptionController,
//   ) async {
//     final amountText = amountController.text;
//     if (amountText.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Please enter an amount')));
//       return;
//     }

//     final amount = double.tryParse(amountText);
//     if (amount == null || amount <= 0) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Please enter a valid amount')));
//       return;
//     }

//     try {
//       await provider.makeDonation(
//         amount,
//         descriptionController.text.isEmpty ? null : descriptionController.text,
//       );

//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Donation successful! Thank you!')),
//         );
//         amountController.clear();
//         descriptionController.clear();
//       }
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(e.toString())));
//       }
//     }
//   }

//   Widget _buildDonationHistory(DonationProvider provider) {
//     if (provider.donations.isEmpty) {
//       return Center(child: Text('No donations yet'));
//     }

//     return ListView.builder(
//       itemCount: provider.donations.length,
//       itemBuilder: (context, index) {
//         final donation = provider.donations[index];
//         return ListTile(
//           title: Text('\$${donation.amount.toStringAsFixed(2)}'),
//           subtitle: Text(
//             '${donation.date.toString().substring(0, 10)} ${donation.description ?? ''}',
//           ),
//           trailing: Icon(Icons.check_circle, color: Colors.green),
//         );
//       },
//     );
//   }
// }
