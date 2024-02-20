import 'package:flutter/material.dart';
import 'package:task2/colors.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.profilePic,
  }) : super(key: key);
  final String message;
  final String date;
  final String  profilePic;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                profilePic,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'images/person.webp',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  );
                },
              ),
              
            ),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              color: senderMessageColor,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 5,
                      top: 5,
                      bottom: 20,
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            Text(
              textAlign:TextAlign.start,
              date,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}