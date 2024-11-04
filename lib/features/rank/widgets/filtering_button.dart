import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';
import 'package:nexus_ranking_system/models/member.dart';

class FilteringButton extends StatefulWidget {
  const FilteringButton({
    super.key,
    required this.filters,
    this.onChanged,
  });

  final List<Field> filters;
  final ValueChanged<Field>? onChanged;

  @override
  State<FilteringButton> createState() => _FilteringButtonState();
}

class _FilteringButtonState extends State<FilteringButton> {
  late Field _selectedFilter;
  late List<Field> filters;
  var alignment = Alignment.center;

  @override
  void initState() {
    super.initState();
    filters = [
      Field(id: null, name: 'All'),
      ...widget.filters
    ];
    _selectedFilter = filters.first;
    alignment = _calculateAlignment(_selectedFilter);
  }

  Alignment _calculateAlignment(Field filter) {
    final index = filters.indexOf(filter);
    final itemCount = filters.length;
    double horizontalAlignment = (2 * index / (itemCount - 1)) - 1;
    return Alignment(horizontalAlignment, 0);
  }

  @override
  Widget build(BuildContext context) {
    var divider = Container(
      height: 40,
      width: 1.25,
      color: CustomColors.grey1,
    );
    final itemCount = filters.length;

    return Container(
      padding: const EdgeInsets.all(5),
      constraints: const BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        color: CustomColors.black2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(itemCount - 1, (index) => divider),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 100),
                alignment: alignment,
                child: Container(
                  height: 60,
                  width: (constraints.maxWidth / itemCount) - 10,
                  decoration: BoxDecoration(
                    color: CustomColors.black3,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  itemCount,
                  (index) {
                    final filter = filters[index];
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFilter = filter;
                            alignment = _calculateAlignment(filter);
                          });
                          if (widget.onChanged != null) {
                            widget.onChanged!(filter);
                          }
                        },
                        child: FilterInfo(
                          title: filters[index].name,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class FilterInfo extends StatelessWidget {
  const FilterInfo({
    super.key, 
    required this.title, 
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyles.style2,
    );
  }
}