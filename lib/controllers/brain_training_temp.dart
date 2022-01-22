import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/models/brain_training.dart';

List<BrainTraining>? brainTrainingData = [
  BrainTraining(
    id: 1,
    title: 'Breathing',
    description:
        'Controlling your breathing can help you relax your body and mind.',
    category: Icons.air_outlined,
    image: "assets/images/brain_cards/breathing.jpg",
  ),
  BrainTraining(
    id: 2,
    title: 'Visualizing',
    description:
        'Mentally imagining a relaxing area can truly relax your brain and body.',
    category: Icons.remove_red_eye_outlined,
    image: "assets/images/brain_cards/visualizing.png",
  ),
  BrainTraining(
    id: 3,
    title: 'Relax Muscles',
    description: 'Anxiety is frequently reduced by relaxing your muscles.',
    category: Icons.fitness_center_outlined,
    image: "assets/images/brain_cards/muscles.jpg",
  ),
  BrainTraining(
    id: 4,
    title: 'Counting',
    description: 'Counting is a simple way to ease your anxiety.',
    category: Icons.format_list_numbered_outlined,
    image: "assets/images/brain_cards/counting.jpg",
  ),
  BrainTraining(
    id: 5,
    title: 'Staying Present',
    description: 'Staying present can help you create a calm state of mind.',
    category: Icons.center_focus_strong_outlined,
    image: "assets/images/brain_cards/present.jpg",
  ),
  BrainTraining(
    id: 6,
    title: 'Anxious Thinking',
    description: 'It can be hard to think clearly when you feel anxious.',
    category: Icons.flight_outlined,
    image: "assets/images/brain_cards/thinking.jpg",
  ),
];
