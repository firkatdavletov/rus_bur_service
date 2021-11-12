import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/machine_notifier.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';

class NoteTextField extends StatefulWidget {
  const NoteTextField({Key? key}) : super(key: key);

  @override
  _NoteTextFieldState createState() => _NoteTextFieldState();
}

class _NoteTextFieldState extends State<NoteTextField> {

  @override
  Widget build(BuildContext context) {

    TextEditingController _controller = TextEditingController(
        text: context.watch<ReportNotifier>().note
    );

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextFormField(
        controller: _controller,
        maxLines: 10,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          counterText: '${_controller.text.split(' ').length}',
          labelText: 'Примечание',
          border: OutlineInputBorder(),
        ),
        onChanged: (text) {
          setState(() {
            context.read<ReportNotifier>().changeNote(text);
          });
        },
      ),
    );
  }
}
