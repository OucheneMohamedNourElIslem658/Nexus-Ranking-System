import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/constents/custom_colors.dart';
import 'package:nexus_ranking_system/constents/text_styles.dart';

enum Filter {
  all,
  mobile,
  web,
  backend,
}

class FilteringButton extends StatefulWidget {
  const FilteringButton({
    super.key,
    required this.filters,
    required this.initialFilter,
    required this.onChanged,
  });

  final List<Filter> filters;
  final Filter initialFilter;
  final ValueChanged<Filter> onChanged;

  @override
  State<FilteringButton> createState() => _FilteringButtonState();
}

class _FilteringButtonState extends State<FilteringButton> {
  late Filter _selectedFilter;
  var alignment = Alignment.center;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
    alignment = _calculateAlignment(_selectedFilter);
  }

  Alignment _calculateAlignment(Filter filter) {
    final index = widget.filters.indexOf(filter);
    final itemCount = widget.filters.length;
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
    final itemCount = widget.filters.length;

    return Container(
      padding: const EdgeInsets.all(5),
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
                    final filter = widget.filters[index];
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFilter = filter;
                            alignment = _calculateAlignment(filter);
                          });
                          widget.onChanged(filter);
                        },
                        child: FilterInfo(
                          title: widget.filters[index].name,
                          memberCount: 12,
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
    required this.memberCount,
  });

  final String title;
  final int memberCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.style2,
        ),
        Text(
          '$memberCount member',
          textAlign: TextAlign.center,
          style: TextStyles.style3,
        ),
      ],
    );
  }
}