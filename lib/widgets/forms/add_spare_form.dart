import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/spare_notifier.dart';
import 'package:rus_bur_service/models/spare.dart';
import 'package:rus_bur_service/pages/spares_page.dart';
import '../../main.dart';
import 'app_text_form_field.dart';

class AddSpareForm extends StatefulWidget {
  final bool isNewSpare;
  final Spare spare;
  const AddSpareForm({
    Key? key,
    required this.spare,
    required this.isNewSpare
  }) : super(key: key);

  @override
  _AddSpareFormState createState() => _AddSpareFormState();
}

class _AddSpareFormState extends State<AddSpareForm> {
  final _formKey_1 = GlobalKey<FormState>();
  _validate(String value) {
    if (value.isEmpty) {
      return 'Пожалуйста, заполните поле';
    }
  }

  _validateInt(String value) {
    if (value.isEmpty) {
      return 'Пожалуйста, заполните поле';
    } else if (value.contains(RegExp(r'0-9'))){
      return 'Введите число';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey_1,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: AppTextFormFieldWithInit(
                initialValue: widget.spare.number,
                onSaved: (value) {
                  context.read<SpareNotifier>().changeNumber(value);
                },
                validator: _validate,
                icon: Icon(Icons.circle, color: Colors.green,),
                label: 'Каталожный номер',
                helperText: '',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: AppTextFormFieldWithInit(
                initialValue: widget.spare.name,
                onSaved: (value) {
                  context.read<SpareNotifier>().changeName(value);
                },
                validator: _validate,
                icon: Icon(Icons.format_quote_sharp),
                label: 'Наименование',
                helperText: '',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: AppTextFormFieldWithInit(
                initialValue: widget.spare.quantity.toString(),
                onSaved: (value) {
                  context.read<SpareNotifier>().changeQuantity(int.parse(value));
                },
                validator: _validateInt,
                icon: Icon(Icons.car_repair),
                label: 'Количество',
                helperText: '',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: AppTextFormFieldWithInit(
                initialValue: widget.spare.measure,
                onSaved: (value) {
                  context.read<SpareNotifier>().changeMeasure(value);
                },
                validator: _validate,
                icon: Icon(Icons.warning_amber_outlined),
                label: 'Единица измерения',
                helperText: '',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: AppTextFormFieldWithInit(
                onSaved: (value) {
                  context.read<SpareNotifier>().changeIssue(value);
                },
                validator: _validate,
                icon: Icon(Icons.recommend),
                label: 'Проблема',
                initialValue: widget.spare.issue,
                helperText: '',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: OutlinedButton (
                  onPressed: () {
                    if (_formKey_1.currentState!.validate()) {
                      _formKey_1.currentState!.save();
                      Spare _newSpare = Spare(
                          id: widget.spare.id,
                          name: Provider.of<SpareNotifier>(context, listen: false).name, 
                          measure: Provider.of<SpareNotifier>(context, listen: false).measure, 
                          issue: Provider.of<SpareNotifier>(context, listen: false).issue, 
                          cardId: widget.spare.cardId, 
                          quantity: Provider.of<SpareNotifier>(context, listen: false).quantity, 
                          number: Provider.of<SpareNotifier>(context, listen: false).number,
                      );
                      widget.isNewSpare 
                        ? db.insertSpare(_newSpare)
                        : db.upgradeSpare(_newSpare);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new SparesPage()
                          )
                      );
                    }
                  },
                  child: Text(widget.isNewSpare? 'Добавить' : 'Сохранить')
              ),
            )
          ],
        )
    );
  }
}
