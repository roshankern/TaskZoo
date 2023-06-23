import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

const maxCharLimit = 20;
const selectedColor = Colors.black;
const backgroundColor = Color.fromRGBO(141, 183, 182, 1);
const unselectedColor = Color.fromRGBO(175, 210, 210, 1);
const lineColor = Color.fromRGBO(140, 146, 146, 1);

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({Key? key}) : super(key: key);

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _tagController = TextEditingController();
  final List<bool> _daysOfWeek = List.filled(7, false);
  bool _biDaily = false;
  bool _weekly = false;
  bool _monthly = false;
  bool _isExpanded = false;
  String _selectedOption = 'Daily';

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Add a New Task',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSelectedOptionTextBox(),
                const SizedBox(height: 16),
                _buildTextField('Task Name', _titleController),
                const SizedBox(height: 16),
                _buildTextField('Tag Name', _tagController),
                const SizedBox(height: 16),
                ExpansionPanelList(
                  elevation: 1,
                  expandedHeaderPadding: const EdgeInsets.all(0),
                  dividerColor: Colors.transparent,
                  expansionCallback: (int index, bool isExpanded) =>
                      setState(() => _isExpanded = !isExpanded),
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return const ListTile(
                          title: Text('Additional Options',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        );
                      },
                      body: Column(
                        children: [
                          _buildDaySelector(),
                          Divider(color: Theme.of(context).dividerColor),
                          const SizedBox(height: 16),
                          _buildBiDailySwitch(),
                          Divider(color: Colors.grey),
                          _buildWeeklySwitch(),
                          Divider(color: Colors.grey),
                          _buildMonthlySwitch(),
                        ],
                      ),
                      isExpanded: _isExpanded,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSubmitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedOptionTextBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        'Task Days: $_selectedOption',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      maxLength: maxCharLimit,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a $label';
        }
        return null;
      },
    );
  }

  Widget _buildDaySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: _biDaily || _weekly || _monthly ? 0.5 : 1.0,
          child: const Text(
            'Select days of the week for the task:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < 7; i++)
              ChoiceChip(
                label: Opacity(
                  opacity: _biDaily || _weekly || _monthly ? 0.5 : 1.0,
                  child: Text(
                    ['M', 'T', 'W', 'T', 'F', 'S', 'S'][i],
                    style: TextStyle(
                        color: _daysOfWeek[i] ? Colors.white : Colors.black),
                  ),
                ),
                selected: _daysOfWeek[i],
                selectedColor: Theme.of(context).primaryColor,
                onSelected: _biDaily || _weekly || _monthly
                    ? null
                    : (selected) {
                        setState(() {
                          _daysOfWeek[i] = selected;
                          if (_daysOfWeek.contains(true)) {
                            _biDaily = false;
                            _weekly = false;
                            _monthly = false;
                            _selectedOption = 'Custom';
                          }
                        });
                      },
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildBiDailySwitch() {
    return IgnorePointer(
      ignoring: _daysOfWeek.contains(true) || _weekly || _monthly,
      child: Opacity(
        opacity: _daysOfWeek.contains(true) || _weekly || _monthly ? 0.5 : 1.0,
        child: SwitchListTile(
          title: const Text(
            'Every 2 Days',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          value: _biDaily,
          onChanged: _daysOfWeek.contains(true)
              ? null
              : (value) {
                  setState(() {
                    _biDaily = value;
                    if (_biDaily) {
                      _daysOfWeek.fillRange(0, 7, false);
                      _weekly = false;
                      _monthly = false;
                      _selectedOption = 'BiDaily';
                    }
                  });
                },
          activeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildWeeklySwitch() {
    return IgnorePointer(
      ignoring: _daysOfWeek.contains(true) || _biDaily || _monthly,
      child: Opacity(
        opacity: _daysOfWeek.contains(true) || _biDaily || _monthly ? 0.5 : 1.0,
        child: SwitchListTile(
          title: const Text(
            'Weekly',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          value: _weekly,
          onChanged: _daysOfWeek.contains(true)
              ? null
              : (value) {
                  setState(() {
                    _weekly = value;
                    if (_weekly) {
                      _daysOfWeek.fillRange(0, 7, false);
                      _biDaily = false;
                      _monthly = false;
                      _selectedOption = 'Weekly';
                    }
                  });
                },
          activeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildMonthlySwitch() {
    return IgnorePointer(
      ignoring: _daysOfWeek.contains(true) || _biDaily || _weekly,
      child: Opacity(
        opacity: _daysOfWeek.contains(true) || _biDaily || _weekly ? 0.5 : 1.0,
        child: SwitchListTile(
          title: const Text(
            'Monthly',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          value: _monthly,
          onChanged: _daysOfWeek.contains(true)
              ? null
              : (value) {
                  setState(() {
                    _monthly = value;
                    if (_monthly) {
                      _daysOfWeek.fillRange(0, 7, false);
                      _biDaily = false;
                      _weekly = false;
                      _selectedOption = 'Monthly';
                    }
                  });
                },
          activeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
      ),
      child: const Text('Add Task'),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final taskData = {
            'title': _titleController.text,
            'tag': _tagController.text,
            'daysOfWeek': _daysOfWeek,
            'biDaily': _biDaily,
            'weekly': _weekly,
            'monthly': _monthly,
          };
          Navigator.pop(context, taskData);
        }
      },
    );
  }
}
