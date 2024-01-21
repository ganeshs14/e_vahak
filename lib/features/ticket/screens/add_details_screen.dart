import 'package:e_vahak/core/common/widgets/primary_button.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:e_vahak/features/ticket/repository/ticket_repository.dart';




class PassengerDetails extends ConsumerStatefulWidget {
  const PassengerDetails({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends ConsumerState<PassengerDetails> {
  void naviateToConformation(BuildContext context) {
    Routemaster.of(context).push('/conformation');
  }

  final color = const Color.fromRGBO(189, 189, 189, 1);
  final List<String> detailList = ["Full Tickets", "Half Tickets"];
  final divide = const Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    child: Divider(
      color: Color.fromRGBO(189, 189, 189, 1),
      thickness: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final ticket = ref.watch(ticketProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ticket Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
        leading: IconButton(
            icon: const Icon(Icons.close, color: Pallete.grey3),
            onPressed: () => Routemaster.of(context).pop(),
          ),
      ),
      body: Column(
        children: [
          const Spacer(),
          _buildDetails(detail: detailList[0]),
          divide,
          _buildDetails(detail: detailList[1]),
          divide,
          const Spacer(
            flex: 4,
          ),
          PrimaryButton(
            title: "Done",
            onTapBtn: ()=> naviateToConformation(context),
          ),
        ],
      ),
    );
  }
   _buildDetails({required String detail}) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            detail,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.remove_circle),
                color: const Color.fromRGBO(15, 163, 210, 1),
                iconSize: 32,
              ),
              const SizedBox(
                width: 100,
                height: 60,
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  // maxLength: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle),
                color: const Color.fromRGBO(15, 163, 210, 1),
                iconSize: 32,
              ),
            ],
          )
        ],
      ),
    );
  }
}
