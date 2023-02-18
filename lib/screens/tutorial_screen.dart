import 'package:flutter/material.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<String> pageTexts = [
    'Pagina 1',
    'Pagina 2',
    'Pagina 3',
    'Pagina 4',
  ];
  final List<String> pageImages = [
    'https://uh.gsstatic.es/sfAttachPlugin/getCachedContent/id/256574/width/730/height/500/crop/1',
    'https://ponsport.com/wp-content/uploads/2016/12/008-1.png',
    'https://ponsport.com/wp-content/uploads/2016/12/009-1.png',
    'https://ponsport.com/wp-content/uploads/2016/12/012-1.png',
  ];
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pageTexts.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: _getColor(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pageTexts[index],
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    Image.network(
                      pageImages[index],
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pageTexts.length,
                (index) => _buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(int index) {
    switch (index) {
      case 0:
        return Color.fromARGB(255, 184, 204, 221);
      case 1:
        return Color.fromARGB(255, 153, 209, 155);
      case 2:
        return Color.fromARGB(255, 230, 194, 140);
      case 3:
        return Color.fromARGB(255, 198, 140, 208);
      default:
        return Colors.white;
    }
  }

  Widget _buildDot(int index) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPageIndex == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}
