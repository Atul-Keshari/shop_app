import 'package:flutter/material.dart';
import 'package:shop_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  Map<String, bool> filters;
  Function applyChang;
  FiltersScreen(this.filters, this.applyChang);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutanFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;
  @override
  void initState() {
    _glutanFree = widget.filters['glutan']!;
    _lactoseFree = widget.filters['lactose']!;
    _vegan = widget.filters['vegan']!;
    _vegetarian = widget.filters['vegetarian']!;
    super.initState();
  }

  Widget _buildSwitchTile(
      String title, String subtitle, bool currVal, void onChang(bool)) {
    return SwitchListTile(
      onChanged: onChang,
      value: currVal,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: [
            IconButton(
              onPressed: () {
                final _selectedFilter = {
                  'lactose': _lactoseFree,
                  'glutan': _glutanFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.applyChang(_selectedFilter);
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              padding: EdgeInsets.all(15),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchTile(
                    'Glutan-free',
                    'Only include glutan-free meal',
                    _glutanFree,
                    (newVal) {
                      setState(
                        () {
                          _glutanFree = newVal;
                        },
                      );
                    },
                  ),
                  _buildSwitchTile(
                    'Lactos-free',
                    'Only include lactose-free meal',
                    _lactoseFree,
                    (newVal) {
                      setState(
                        () {
                          _lactoseFree = newVal;
                        },
                      );
                    },
                  ),
                  _buildSwitchTile(
                    'Vegan',
                    'Only include vegan meal',
                    _vegan,
                    (newVal) {
                      setState(
                        () {
                          _vegan = newVal;
                        },
                      );
                    },
                  ),
                  _buildSwitchTile(
                    'Vegetarian',
                    'Only include vegetarian meal',
                    _vegetarian,
                    (newVal) {
                      setState(
                        () {
                          _vegetarian = newVal;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
