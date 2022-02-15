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
    steps: [
      'Sit in a quiet and comfortable place. Put one of your hands on your chest and the other on your stomach. Your stomach should move more than your chest when you breathe in deeply.',
      'Take a slow and regular breath in through your nose. Watch and sense your hands as you breathe in. The hand on your chest should remain still while the hand on your stomach will move slightly.',
      'Breathe out through your mouth slowly.',
      'Repeat this process at least 10 times or until you begin to feel your anxiety lessen.'
    ],
  ),
  BrainTraining(
    id: 2,
    title: 'Visualizing',
    description:
        'Mentally imagining a relaxing area can truly relax your brain and body.',
    category: Icons.remove_red_eye_outlined,
    image: "assets/images/brain_cards/visualizing.png",
    steps: [
      'Sit in a quiet and comfortable place.',
      'Think of your ideal place to relax. While it can be any place in the world, real or imaginary, it should be an image that you find very calming, happy, peaceful, and safe.',
      'Think of all the small details you’d find if you were there. Think about how the place would smell, feel, and sound. Envision yourself in that place, enjoying it comfortably.',
      'Once you have a good picture of your “happy place,” close your eyes and take slow and regular breaths through your nose and out of your mouth.',
      'Be aware of your breathing and continue focusing on the place you’ve imagined in your mind until you feel your anxiety lifting.'
    ],
  ),
  BrainTraining(
      id: 3,
      title: 'Relax Muscles',
      description: 'Anxiety is frequently reduced by relaxing your muscles.',
      category: Icons.fitness_center_outlined,
      image: "assets/images/brain_cards/muscles.jpg",
      steps: [
        'Sit in a quiet and comfortable place. Close your eyes and focus on your breathing. Breathe slowly into your nose and out of your mouth.',
        'Use your hand to make a tight fist. Squeeze your fist tightly.',
        'Hold your squeezed fist for a few seconds. Notice all the tension you feel in your hand.',
        'Slowly open your fingers and be aware of how you feel. You may notice a feeling of tension leaving your hand. Eventually, your hand will feel lighter and more relaxed.',
        'Continue tensing and then releasing various muscle groups in your body, from your hands, legs, shoulders, or feet. You may want to work your way up and down your body tensing various muscle groups. Avoid tensing the muscles in any area of your body where you’re injured or in pain, as that may further aggravate your injury.'
      ]),
  BrainTraining(
      id: 4,
      title: 'Counting',
      description: 'Counting is a simple way to ease your anxiety.',
      category: Icons.format_list_numbered_outlined,
      image: "assets/images/brain_cards/counting.jpg",
      steps: [
        'Find a quiet and comfortable place to sit.',
        'Close your eyes and slowly count to 10.',
        'If necessary, repeat and count to 20 or an even higher number.',
        'Keep counting until you feel your anxiety subsiding.'
      ]),
  BrainTraining(
      id: 5,
      title: 'Staying Present',
      description: 'Staying present can help you create a calm state of mind.',
      category: Icons.center_focus_strong_outlined,
      image: "assets/images/brain_cards/present.jpg",
      steps: [
        'Find a quiet and comfortable place to sit and close your eyes.',
        'Notice how your breathing and body feel.',
        'Now shift your awareness to the sensations you observe in your surroundings. Ask yourself What\'s happening outside of my body? Notice what you hear, smell, and feel in your environment.',
        'Change your awareness several times from your body to your environment and back again until your anxiety starts to fade.',
      ]),
  BrainTraining(
      id: 6,
      title: 'Anxious Thinking',
      description: 'It can be hard to think clearly when you feel anxious.',
      category: Icons.flight_outlined,
      image: "assets/images/brain_cards/thinking.jpg",
      steps: [
        'Ask yourself whether endless worry is a problem for you. If the answer is yes, it’s good to be aware of that.',
        'Singing a silly song about your anxiety to an upbeat tempo, or speaking your anxieties in a funny voice.',
        'Choose a nice thought to focus on instead of your anxiety. This could be a person you love, your happy place, or even something you look forward to doing later that day, such as eating a nice dinner.',
        'Listen to music or read a book.',
        'Be conscious when you shift your attention from your anxiety to a task at hand and notice how you feel.'
      ]),
];
