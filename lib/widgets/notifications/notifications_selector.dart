import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationsWidget extends StatefulWidget {
  final Function(bool enableNotifications, List<bool> selectedWeekdays,
      TimeOfDay notiTime) onEnableNotificationsChanged;
  final bool? enableNotifications;
  final List<bool>? selectedWeekdays;
  final TimeOfDay? notiTime;

  const NotificationsWidget({
    required this.onEnableNotificationsChanged,
    this.enableNotifications,
    this.selectedWeekdays,
    this.notiTime,
  });

  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState(
        enableNotifications: enableNotifications,
        selectedWeekdays: selectedWeekdays,
        notiTime: notiTime,
      );
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  List<bool> _selectedWeekdays;
  TimeOfDay _selectedTime;
  bool _enableNotifications;

  _NotificationsWidgetState({
    bool? enableNotifications,
    List<bool>? selectedWeekdays,
    TimeOfDay? notiTime,
  })  : _enableNotifications = enableNotifications ?? false,
        _selectedWeekdays =
            selectedWeekdays ?? List.generate(7, (index) => false),
        _selectedTime = notiTime ?? TimeOfDay.now();

  void _selectWeekday(int index, bool value) {
    setState(() {
      _selectedWeekdays[index] = value;
    });
  }

  void _selectTime(TimeOfDay time) {
    setState(() {
      _selectedTime = time;
    });
  }

  void _toggleEnableNotifications(bool value) {
    setState(() {
      _enableNotifications = value;
      if (!_enableNotifications) {
        // Disable other buttons if notifications are disabled
        _selectedWeekdays = List.generate(7, (index) => false);
      }
      widget.onEnableNotificationsChanged(
          _enableNotifications, _selectedWeekdays, _selectedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Enable Notifications:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Switch(
              value: _enableNotifications,
              onChanged: _toggleEnableNotifications,
              activeColor: Colors.black,
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Select Weekdays for Notifications:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          alignment: WrapAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final weekday = DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 1 + index));
            return ChoiceChip(
              label: Opacity(
                opacity: 1,
                child: Text(
                  ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                  style: TextStyle(
                    color:
                        _selectedWeekdays[index] ? Colors.white : Colors.black,
                  ),
                ),
              ),
              selected: _selectedWeekdays[index],
              selectedColor: Colors.black,
              onSelected: _enableNotifications
                  ? (selected) {
                      setState(() {
                        _selectedWeekdays[index] = selected;
                      });
                      widget.onEnableNotificationsChanged(_enableNotifications,
                          _selectedWeekdays, _selectedTime);
                    }
                  : null,
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 8),
        Center(
          child: ElevatedButton(
            onPressed: _enableNotifications
                ? () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Colors.black,
                            buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary,
                              buttonColor: Colors.black,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      _selectTime(picked);
                    }
                    widget.onEnableNotificationsChanged(
                        _enableNotifications, _selectedWeekdays, _selectedTime);
                  }
                : null,
            style: ElevatedButton.styleFrom(primary: Colors.black),
            child: const Text(
              'Select Time',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        if (_enableNotifications)
          Text(
            'Selected Time: ${_selectedTime.format(context)}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}
