import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/commun/repos/rank.dart';
import 'package:nexus_ranking_system/features/admin/screens/edit_member.dart';
import 'package:nexus_ranking_system/models/member.dart';

class AdminBoard extends StatefulWidget {
  const AdminBoard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminBoardState createState() => _AdminBoardState();
}

class _AdminBoardState extends State<AdminBoard> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Board'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Search members',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Member>>(
              stream: RankRepo.getMembersStream(query: _query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}', 
                      style: const TextStyle(color: Colors.white)
                    )
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No members found',
                      style: TextStyle(color: Colors.white)
                    )
                  );
                }

                final members = snapshot.data!;
                return ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: member.imageURL != null
                            ? NetworkImage(member.imageURL!)
                            : null,
                      ),
                      title: Text(
                        member.name,
                        style: const TextStyle(
                          color: Colors.white
                        ),
                      ),
                      subtitle: Text('Total Score: ${member.totalScore}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => EditPersonScreen(uid: member.uid))
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}