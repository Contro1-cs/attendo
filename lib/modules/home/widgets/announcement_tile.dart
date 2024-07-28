import 'package:attendo/modules/home/models/announcement_model.dart';
import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementTile extends StatefulWidget {
  final AnnouncementModel announcement;
  const AnnouncementTile({super.key, required this.announcement});

  @override
  State<AnnouncementTile> createState() => _AnnouncementTileState();
}

class _AnnouncementTileState extends State<AnnouncementTile> {
  bool _isExpanded = false;
  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM').format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomColors.placeholder,
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.announcement.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formatDate(DateTime.parse(widget.announcement.dateTime)),
                style: const TextStyle(
                  fontSize: 14,
                  color: CustomColors.placeholder,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                formatTime(DateTime.parse(widget.announcement.dateTime)),
                style: const TextStyle(
                  fontSize: 14,
                  color: CustomColors.placeholder,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              widget.announcement.content,
              maxLines: _isExpanded ? null : 3,
              overflow: _isExpanded ? null : TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: CustomColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
