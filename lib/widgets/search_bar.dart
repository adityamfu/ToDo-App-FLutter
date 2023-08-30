import 'package:flutter/material.dart';

class SearchBr extends StatefulWidget {
  const SearchBr({Key? key}) : super(key: key);

  @override
  State<SearchBr> createState() => _SearchBrState();
}

class _SearchBrState extends State<SearchBr>
    with SingleTickerProviderStateMixin {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!_isActive)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hai Adit!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Jangan Lupa Kuliahnya !!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 250),
                child: _isActive
                    ? Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search...',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isActive = false;
                                    });
                                  },
                                  icon: const Icon(Icons.close))),
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _isActive = true;
                          });
                        },
                        icon: const Icon(Icons.search)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
