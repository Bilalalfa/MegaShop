import 'dart:io'; // Perlu ditambahkan untuk membaca File
import 'package:flutter/material.dart';

import 'edit_profile_screen.dart';
import 'order_detail_screen.dart';
import 'post_detail_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Asyraf';
  String username = 'asyraf_dev';
  String bio = 'Tech Enthusiast | Flutter Developer\nMembangun MegaShop App 🚀';
  String profileImageUrl =
      'https://ui-avatars.com/api/?name=Asyraf&background=random&size=200';

  // Fungsi cerdas untuk menentukan jenis gambar
  ImageProvider _getProfileImage() {
    if (profileImageUrl.startsWith('http')) {
      return NetworkImage(profileImageUrl);
    } else {
      return FileImage(File(profileImageUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            username,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.history, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_box_outlined, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 16),
                    _buildProfileDescription(),
                    const SizedBox(height: 16),
                    _buildActionButtons(context),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Colors.grey),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_on)),
                      Tab(icon: Icon(Icons.bookmark_border_outlined)),
                      Tab(icon: Icon(Icons.assignment_ind_outlined)),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildPostGrid(seed: 'posts'),
              _buildPostGrid(seed: 'saved'),
              _buildPostGrid(seed: 'tagged'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 2),
              image: DecorationImage(
                image: _getProfileImage(), // Panggil fungsi di sini
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('15', 'Posts'),
                _buildStatColumn('4.5K', 'Followers'),
                _buildStatColumn('350', 'Following'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildProfileDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(bio, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      initialName: name,
                      initialUsername: username,
                      initialBio: bio,
                      initialImageUrl: profileImageUrl,
                    ),
                  ),
                );

                if (result != null && result is Map<String, String>) {
                  setState(() {
                    name = result['name'] ?? name;
                    username = result['username'] ?? username;
                    bio = result['bio'] ?? bio;
                    profileImageUrl = result['imageUrl'] ?? profileImageUrl;
                  });
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Edit Profile'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Share Profile'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostGrid({required String seed}) {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 15,
      itemBuilder: (context, index) {
        final imageUrl = 'https://picsum.photos/seed/$seed$index/500';
        final bool isVideo = index % 4 == 0;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailScreen(
                  imageUrl: imageUrl,
                  title: 'Postingan ${index + 1}',
                  username: username,
                  userImage:
                      profileImageUrl, // Mengirim data ke halaman Post Detail
                ),
              ),
            );
          },
          child: Container(
            color: Colors.grey.shade300,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: imageUrl,
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
                if (isVideo)
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
