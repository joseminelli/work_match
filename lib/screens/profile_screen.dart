import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late List<Animation<double>> _itemAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final appliedJobs = appState.appliedJobs;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        },
        child: const Icon(Icons.exit_to_app),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50.0),
            FadeTransition(
              opacity: _fadeIn,
              child: const Text(
                'Perfil',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0),
            AnimatedScale(
              duration: const Duration(seconds: 1),
              scale: 1.2,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: Image.network(
                  'https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png',
                ).image,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              appState.getusername(),
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Suas aplicações',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, fontSize: 18)),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: appliedJobs.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            const Icon(Icons.sentiment_dissatisfied),
                            const SizedBox(width: 8.0),
                            Text(
                              'Você não se candidatou a nenhuma vaga ainda.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ])
                    : AnimatedList(
                        initialItemCount: appliedJobs.length,
                        itemBuilder: (context, index, animation) {
                          // Cada item da lista vai ter uma animação de entrada
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: ListTile(
                                  title: Text(
                                    appliedJobs[index].title,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                    appliedJobs[index].company,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      appState
                                          .removeAppliedJob(appliedJobs[index]);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
