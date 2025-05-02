import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/profile_cubit/profile_cubit.dart';
import '../repository/user_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(userRepository: UserRepository())..fetchUserProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/default_profile.png'),
                    ),
                    SizedBox(height: 10),
                    Text(user.username, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(user.email, style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCount('Followers', user.followers.length),
                        _buildCount('Following', user.following.length),
                        _buildCount('Posts', user.posts.length),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: user.posts.length,
                      itemBuilder: (context, index) {
                        final post = user.posts[index];
                        return ListTile(
                          title: Text(post.content),
                          subtitle: post.imageUrl != null
                              ? Image.network(post.imageUrl!)
                              : null,
                        );
                      },
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildCount(String title, int count) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
