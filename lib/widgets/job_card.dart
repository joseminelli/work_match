import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/jobs.dart';
import '../app_state.dart';

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    job.logo,
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, size: 40);
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(job.company),
                      Text(job.type),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              job.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8.0),
            Consumer<AppState>(
              builder: (context, appState, child) {
                final isApplied = appState.isJobApplied(job);
                return ElevatedButton(
                  onPressed: () {
                    isApplied
                        ? appState.removeAppliedJob(job)
                        : appState.applyToJob(job);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 0),
                    backgroundColor: isApplied
                        ? const Color.fromARGB(255, 224, 214, 205)
                        : const Color.fromARGB(255, 252, 223, 195),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                  ),
                  child: Text(isApplied ? 'Candidatado' : 'Candidatar'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
