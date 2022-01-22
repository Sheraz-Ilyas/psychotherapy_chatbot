import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/models/article.dart';

RichText text = RichText(
  textAlign: TextAlign.justify,
  text: const TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Facundo',
      ),
      children: [
        TextSpan(
            text:
                """According to the National Institute of Mental Health, anxiety disorders are the most common mental illness in the United States. That’s 40 million adults—18% of the population—who struggle with anxiety. Anxiety and depression often go hand in hand, with about half of those with depression also experiencing anxiety.

Specific therapies and medications can help relieve the burden of anxiety, yet only about a third of people suffering from this condition seek treatment. In my practice, part of what I discuss when explaining treatment options is the important role of diet in helping to manage anxiety.

In addition to healthy guidelines such as eating a balanced diet, drinking enough water to stay hydrated, and limiting or avoiding alcohol and caffeine, there are many other dietary considerations that can help relieve anxiety. For example, complex carbohydrates are metabolized more slowly and therefore help maintain a more even blood sugar level, which creates a calmer feeling.
A diet rich in whole grains, vegetables, and fruits is a healthier option than eating a lot of simple carbohydrates found in processed foods. When you eat is also important. Don’t skip meals. Doing so may result in drops in blood sugar that cause you to feel jittery, which may worsen underlying anxiety.

The gut-brain axis is also very important, since a large percentage (about 95%) of serotonin receptors are found in the lining of the gut. Research is examining the potential of probiotics for treating both anxiety and depression."""),
        TextSpan(
            text: "\n\nMake these foods a part of your anti-anxiety diet",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            )),
        TextSpan(
            text:
                """\n\nYou might be surprised to learn that specific foods have been shown to reduce anxiety.

\u2022 In mice, diets low in magnesium were found to increase anxiety-related behaviors. Foods naturally rich in magnesium may, therefore, help a person to feel calmer. Examples include leafy greens, such as spinach and Swiss chard. Other sources include legumes, nuts, seeds, and whole grains.
\u2022 Foods rich in zinc such as oysters, cashews, liver, beef, and egg yolks have been linked to lowered anxiety.
\u2022 Other foods, including fatty fish like wild Alaskan salmon, contain omega-3 fatty acids. A study completed on medical students in 2011 was one of the first to show that omega-3s may help reduce anxiety. (This study used supplements containing omega-3 fatty acids). Prior to the study, omega-3 fatty acids had been linked to improving depression only.
\u2022 A study in the journal Psychiatry Research suggested a link between probiotic foods and a lowering of social anxiety. Eating probiotic-rich foods such as pickles, sauerkraut, and kefir was linked with fewer symptoms.
\u2022 Asparagus, known widely to be a healthy vegetable. Based on research, the Chinese government approved the use of an asparagus extract as a natural functional food and beverage ingredient due to its anti-anxiety properties.
\u2022 Foods rich in B vitamins, such as avocado and almonds
\u2022 These "feel good" foods spur the release of neurotransmitters such as serotonin and dopamine. They are a safe and easy first step in managing anxiety."""),
        TextSpan(
            text:
                "\n\nShould antioxidants be included in your anti-anxiety diet?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        TextSpan(
            text:
                """\n\nAnxiety is thought to be correlated with a lowered total antioxidant state. It stands to reason, therefore, that enhancing your diet with foods rich in antioxidants may help ease the symptoms of anxiety disorders. A 2010 study reviewed the antioxidant content of 3,100 foods, spices, herbs, beverages, and supplements. Foods designated as high in antioxidants by the USDA include:

\u2022 Beans: Dried small red, Pinto, black, red kidney
\u2022 Fruits: Apples (Gala, Granny Smith, Red Delicious), prunes, sweet cherries, plums, black plums
\u2022 Berries: Blackberries, strawberries, cranberries, raspberries, blueberries
\u2022 Nuts: Walnuts, pecans
\u2022 Vegetables: Artichokes, kale, spinach, beets, broccoli
\u2022 Spices with both antioxidant and anti-anxiety properties include turmeric (containing the active ingredient curcumin) and ginger."""),
        TextSpan(
            text: "\n\nAchieving better mental health through diet",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        TextSpan(
            text:
                """\n\nBe sure to talk to your doctor if your anxiety symptoms are severe or last more than two weeks. But even if your doctor recommends medication or therapy for anxiety, it is still worth asking whether you might also have some success by adjusting your diet. While nutritional psychiatry is not a substitute for other treatments, the relationship between food, mood, and anxiety is garnering more and more attention. There is a growing body of evidence, and more research is needed to fully understand the role of nutritional psychiatry, or as I prefer to call it, Psycho-Nutrition.""")
      ]),
);

Article? articleData = Article(
  id: 1,
  title: "Nutritional Strategies to Ease Anxiety",
  author: "Uma Naidoo",
  datePosted: "2 hours ago",
  content: text,
  image: "assets/images/brain_training_1.jpg",
  category: "Health    -    Diet",
);
