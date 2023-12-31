import 'package:flutter/material.dart';

class VocaPage extends StatefulWidget {
  const VocaPage({super.key});

  @override
  State<VocaPage> createState() => _VocaPageState();
}

class _VocaPageState extends State<VocaPage> {
  final List<String> _listItems = [];
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _meanOneController = TextEditingController();
  final TextEditingController _meanTwoController = TextEditingController();
  final TextEditingController _meanThreeController = TextEditingController();
  final TextEditingController _wordClassOneController = TextEditingController();
  final TextEditingController _wordClassTwoController = TextEditingController();
  final TextEditingController _wordClassThreeController = TextEditingController();
  final TextEditingController _exampleSentenceController = TextEditingController();
  final Map<String, List<String>> _exampleSentences = {};

  void _addItemToList() {
    String word = _wordController.text;
    List<String> meanings = [];

    if (_meanOneController.text.isNotEmpty &&
        _wordClassOneController.text.isNotEmpty) {
      meanings.add(
          '(${_wordClassOneController.text}) ${_meanOneController.text}');
    }
    if (_meanTwoController.text.isNotEmpty &&
        _wordClassTwoController.text.isNotEmpty) {
      meanings.add(
          '(${_wordClassTwoController.text}) ${_meanTwoController.text}');
    }
    if (_meanThreeController.text.isNotEmpty &&
        _wordClassThreeController.text.isNotEmpty) {
      meanings.add(
          '(${_wordClassThreeController.text}) ${_meanThreeController.text}');
    }

    String combinedText = "$word     ${meanings.join(',   ')}";

    setState(() {
      _listItems.add(combinedText);
      _wordController.clear();
      _meanOneController.clear();
      _meanTwoController.clear();
      _meanThreeController.clear();
      _wordClassOneController.clear();
      _wordClassTwoController.clear();
      _wordClassThreeController.clear();
      Navigator.pop(context);
    });
  }
  void addWord() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom + 20, // 키보드 높이만큼 패딩을 추가
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _wordController,
                decoration: InputDecoration(
                  labelText: '단어',
                  hintText: '단어를 입력하세요',
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _meanOneController,
                      decoration: InputDecoration(
                        labelText: '뜻',
                        hintText: '첫 번째 뜻을 입력하세요',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _wordClassOneController,
                      decoration: InputDecoration(
                        labelText: '품사',
                        hintText: '첫 번째 품사를 입력하세요',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _meanTwoController,
                      decoration: InputDecoration(
                        labelText: '뜻',
                        hintText: '두 번째 뜻을 입력하세요',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _wordClassTwoController,
                      decoration: InputDecoration(
                        labelText: '품사',
                        hintText: '두 번째 품사를 입력하세요',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _meanThreeController,
                      decoration: InputDecoration(
                        labelText: '뜻',
                        hintText: '세 번째 뜻을 입력하세요',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _wordClassThreeController,
                      decoration: InputDecoration(
                        labelText: '품사',
                        hintText: '세 번째 품사를 입력하세요',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('추가'),
                onPressed: _addItemToList,
              ),
            ],
          ),
        );
      },
    );
  }
  void _showAddExampleDialog(String word) {
    showDialog(
      context: context,
      barrierDismissible: false, // This line will prevent the dialog from closing when tapping outside of it.
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('예문 추가'),
          content: TextField(
            controller: _exampleSentenceController,
            decoration: InputDecoration(hintText: '예문을 입력하세요'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                _addExampleSentence(word);
                // Do not pop the dialog.
                _exampleSentenceController.clear(); // Clear the input field for new input.
                setState(() {}); // Refresh the state to update the UI if needed.
              },
            ),
            TextButton(
              child: Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop(); // This will still allow the user to close the dialog if they wish.
              },
            ),
          ],
        );
      },
    );
  }
  void _addExampleSentence(String word) {
    if (_exampleSentenceController.text.isNotEmpty) {
      setState(() {
        _exampleSentences.putIfAbsent(word, () => []).add(
            _exampleSentenceController.text);
        _exampleSentenceController.clear();
      });
    }
  }
  void _showDetailsDialog(String item) {
    final parts = item.split('     ');
    final word = parts[0];
    final meanings = parts.length > 1 ? parts[1].split(',   ') : [];
    final examples = _exampleSentences[word] ?? [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(word),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ...meanings.map((meaning) => Text(meaning)).toList(),
                  SizedBox(height: 20),
                  Text('예문:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...examples.map((example) => Text('• $example')).toList(),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('예문 추가'),
              onPressed: () {
                Navigator.of(context).pop();
                _showAddExampleDialog(word);
              },
            ),
            TextButton(
              child: Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('단어장'), // 가운데 텍스트
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), // 오른쪽 아이콘
            onPressed: () {},
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: _listItems.length,
        itemBuilder: (context, index) {
          final item = _listItems[index];
          return Dismissible(
            key: Key(item),
            onDismissed: (direction) {
              setState(() {
                _listItems.removeAt(index);
              });

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$item 삭제되었습니다.')));
            },
            // background: Container(color: Colors.red),
            child: ListTile(
              title: Text(item),
              onTap: () => _showDetailsDialog(item),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addWord,
        child: Icon(Icons.add),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
            ),
            ListTile(
              title: const Text('Business'),
            ),
            ListTile(
              title: const Text('School'),
            ),
          ],
        ),
      ),
    );
  }
}