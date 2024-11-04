import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/commun/repos/rank.dart';
import 'package:nexus_ranking_system/features/admin/repos/admin.dart';
import 'package:nexus_ranking_system/models/member.dart';

class EditPersonScreen extends StatefulWidget {
  final String uid;

  const EditPersonScreen({super.key, required this.uid});

  @override
  // ignore: library_private_types_in_public_api
  _EditPersonScreenState createState() => _EditPersonScreenState();
}

class _EditPersonScreenState extends State<EditPersonScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late Member? _member;
  bool _isLoading = true;
  List<Field> _allFields = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch fields dynamically
      _allFields = await AdminRepository.getFields(); // Fetch all fields dynamically here
      _member = await RankRepo.getCurrentUserScores(widget.uid);

      if (_member != null) {
        _nameController.text = _member!.name;
        _emailController.text = _member!.email;
        _initializeScores();
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _initializeScores() {
    for (var field in _allFields) {
      if (!_member!.scores.any((score) => score.field == field.id)) {
        _member!.scores.add(Score(fieldInfo: field, points: 0, field: field.id));
      }
    }
  }

  Future<void> _saveChanges() async {
    if (_member == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await AdminRepository.updateField(
        context,
        widget.uid,
        newFieldName: _nameController.text,
      );
      await _updateUserScores();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserScores() async {
    if (_member == null) return;
    for (var score in _member!.scores) {
      await AdminRepository.updateUserScore(
        context,
        userId: widget.uid,
        fieldId: score.field!,
        newScore: score.points,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Member'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), 
          icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white,),
            onPressed: _isLoading ? null : _saveChanges,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _member == null
              ? const Center(child: Text('Member not found'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Scores',
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const SizedBox(height: 20),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _member!.scores.length,
                          itemBuilder: (context, index) {
                            final score = _member!.scores[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                score.fieldInfo!.name,
                                style: const TextStyle(color: Colors.white)
                              ),
                              trailing: SizedBox(
                                width: 80,
                                child: TextFormField(
                                  initialValue: score.points.toString(),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    score.points = int.tryParse(value) ?? score.points;
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    labelText: 'Points',
                                    labelStyle: TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
