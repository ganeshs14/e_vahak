// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_vahak/features/home/screens/drawer.dart';
import 'package:e_vahak/features/home/screens/ticket_card.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void navigateToSelectSource(BuildContext context) {
    Routemaster.of(context).push('/selectSource');
  }

  void navigateToBookPass(BuildContext context) {
    Routemaster.of(context).push('/bookpass');
  }

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  String qrScanRes = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String qrScanRes;
    try {
      qrScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      debugPrint(qrScanRes);
    } on PlatformException {
      qrScanRes = "Failed to get platform version.";
    }
    if (!mounted) return;

    setState(() {
      qrScanRes = qrScanRes;
    });

    // Navigate to a new page with the result
    navigateToSelectSource(context);
  }

  @override
  Widget build(BuildContext context) {
    //print(ref.read(authRepositoryProvider).currentUser);
    //print(ref.read(userIdprovider));
    //print('hello');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Vahak',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: Builder(builder: (context) {
          return IconButton(
              icon: const Icon(Icons.menu, color: Pallete.grey3),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Tickets',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
            ),
            ref.watch(getTicketProvider).when(
                data: (ticket) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: ticket.length,
                        itemBuilder: (context, index) {
                          //print(ticket[index].ticketId.toString());
                          return TicketCard(
                            source: ticket[index].source,
                            destination: ticket[index].destination,
                            fullSeats: ticket[index].fullSeats,
                            halfSeats: ticket[index].halfSeats,
                            price: ticket[index].price,
                            tid: ticket[index].ticketId.toString(),
                          );
                        }),
                  );
                },
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (error, stackTrace) {
                  if (kDebugMode) {
                    print(error.toString());
                    print(stackTrace.toString());
                  }

                  return Center(
                    child: Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  );
                }),
            PrimaryButton(
                title: 'Book Pass',
                onTapBtn: () {
                  navigateToBookPass(context);
                }),
            PrimaryButton(
                title: 'Book Tickets',
                onTapBtn: () {
                  scanQR();
                }),
            // onTapBtn: () => navigateToSelectSource(context)
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      drawer: const MainDrawer(),
    );
  }
}
