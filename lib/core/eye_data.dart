import 'series_order.dart';

/// The offline watch-order catalogue for AniEye.
///
/// All entries are factual/editorial viewing orders with short original notes.
/// No copyrighted text, synopses or media are included.
class EyeData {
  const EyeData._();

  static const List<SeriesOrder> series = <SeriesOrder>[
    SeriesOrder(
      id: 'monogatari',
      name: 'Monogatari',
      short: 'Bakemonogatari and beyond',
      blurb:
          'A dialogue-heavy supernatural series best followed in its original '
          'airing order for the intended reveals.',
      orderType: 'Release (airing) order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'Bakemonogatari', note: 'The entry point.'),
        WatchStep(order: 2, title: 'Nisemonogatari'),
        WatchStep(order: 3, title: 'Nekomonogatari (Black)'),
        WatchStep(
            order: 4,
            title: 'Monogatari Series: Second Season',
            note: 'The largest arc block.'),
        WatchStep(order: 5, title: 'Hanamonogatari'),
        WatchStep(order: 6, title: 'Tsukimonogatari'),
        WatchStep(order: 7, title: 'Owarimonogatari'),
        WatchStep(order: 8, title: 'Koyomimonogatari'),
        WatchStep(order: 9, title: 'Kizumonogatari films', note: 'A prequel.'),
        WatchStep(order: 10, title: 'Owarimonogatari (Part 2)'),
        WatchStep(order: 11, title: 'Zoku Owarimonogatari'),
      ],
    ),
    SeriesOrder(
      id: 'fate',
      name: 'Fate',
      short: 'Fate/stay night universe',
      blurb:
          'Multiple alternate routes. This order keeps the main Fate/stay night '
          'routes together before branching out.',
      orderType: 'Recommended order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'Fate/stay night (2006)', note: 'Saber route.'),
        WatchStep(order: 2, title: 'Fate/stay night: Unlimited Blade Works',
            note: 'Rin route.'),
        WatchStep(order: 3, title: 'Fate/stay night: Heaven\'s Feel movies',
            note: 'Sakura route; watch the trilogy in order.'),
        WatchStep(order: 4, title: 'Fate/Zero', note: 'Prequel to the above.',
            isOptional: false),
        WatchStep(
            order: 5,
            title: 'Fate/Grand Order: First Order',
            isOptional: true),
        WatchStep(
            order: 6,
            title: 'Fate/Apocrypha',
            note: 'Separate timeline.',
            isOptional: true),
        WatchStep(
            order: 7,
            title: 'Fate/Extra: Last Encore',
            isOptional: true),
        WatchStep(
            order: 8,
            title: 'Today\'s Menu for the Emiya Family',
            note: 'A lighthearted spinoff.',
            isOptional: true),
      ],
    ),
    SeriesOrder(
      id: 'haruhi',
      name: 'Haruhi Suzumiya',
      short: 'The Melancholy of Haruhi Suzumiya',
      blurb:
          'Choose between the DVD broadcast order and the chronological order. '
          'Broadcast order preserves the original mystery.',
      orderType: 'Broadcast order',
      steps: <WatchStep>[
        WatchStep(
            order: 1,
            title: 'The Melancholy of Haruhi Suzumiya (2006)',
            note: 'Aired out of chronological order.'),
        WatchStep(
            order: 2,
            title: 'The Melancholy of Haruhi Suzumiya (2009)',
            note: 'Includes the "Endless Eight" arc.'),
        WatchStep(
            order: 3,
            title: 'The Disappearance of Haruhi Suzumiya',
            note: 'Feature film.'),
        WatchStep(
            order: 4,
            title: 'The Disappearance of Nagato Yuki-chan',
            note: 'Alternate spinoff.',
            isOptional: true),
      ],
    ),
    SeriesOrder(
      id: 'jojo',
      name: 'JoJo\'s Bizarre Adventure',
      short: 'Joestar family saga',
      blurb:
          'Parts follow bloodlines across generations. Watching in part order is '
          'the intended experience.',
      orderType: 'Part order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'Phantom Blood', note: 'Part 1.'),
        WatchStep(order: 2, title: 'Battle Tendency', note: 'Part 2.'),
        WatchStep(order: 3, title: 'Stardust Crusaders', note: 'Part 3.'),
        WatchStep(order: 4, title: 'Diamond is Unbreakable', note: 'Part 4.'),
        WatchStep(order: 5, title: 'Golden Wind', note: 'Part 5.'),
        WatchStep(order: 6, title: 'Stone Ocean', note: 'Part 6.'),
      ],
    ),
    SeriesOrder(
      id: 'gintama',
      name: 'Gintama',
      short: 'Comedy with serious arcs',
      blurb:
          'Mostly episodic, but the serious arcs build to a finale. Follow the '
          'season order and don\'t skip the movies.',
      orderType: 'Season order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'Gintama (2006)'),
        WatchStep(order: 2, title: 'Gintama (Season 2)'),
        WatchStep(order: 3, title: 'Gintama (Season 3)'),
        WatchStep(order: 4, title: 'Gintama (Season 4)'),
        WatchStep(order: 5, title: 'Gintama°'),
        WatchStep(order: 6, title: 'Gintama.'),
        WatchStep(
            order: 7,
            title: 'Gintama: The Movie',
            note: 'Recap film; optional.',
            isOptional: true),
        WatchStep(order: 8, title: 'Gintama. (Porori-hen)'),
        WatchStep(order: 9, title: 'Gintama: Silver Soul'),
        WatchStep(order: 10, title: 'Gintama: The Very Final', note: 'Ending.'),
      ],
    ),
    SeriesOrder(
      id: 'onepiece',
      name: 'One Piece',
      short: 'Long-running pirate adventure',
      blurb:
          'Hundreds of episodes across sagas. Watch in airing order, or use the '
          'saga grouping to plan.',
      orderType: 'Saga order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'East Blue Saga'),
        WatchStep(order: 2, title: 'Alabasta Saga'),
        WatchStep(order: 3, title: 'Sky Island Saga'),
        WatchStep(order: 4, title: 'Water 7 Saga'),
        WatchStep(order: 5, title: 'Thriller Bark Saga'),
        WatchStep(order: 6, title: 'Summit War Saga'),
        WatchStep(order: 7, title: 'Fish-Man Island Saga'),
        WatchStep(order: 8, title: 'Dressrosa Saga'),
        WatchStep(order: 9, title: 'Whole Cake Island Saga'),
        WatchStep(order: 10, title: 'Wano Country Saga'),
        WatchStep(order: 11, title: 'Final Saga', note: 'Ongoing.'),
      ],
    ),
    SeriesOrder(
      id: 'ghibli',
      name: 'Studio Ghibli',
      short: 'A route through the classics',
      blurb:
          'Stand-alone films. This is a gentle introduction order rather than a '
          'continuity order.',
      orderType: 'Suggested starter order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'My Neighbor Totoro'),
        WatchStep(order: 2, title: 'Kiki\'s Delivery Service'),
        WatchStep(order: 3, title: 'Castle in the Sky'),
        WatchStep(order: 4, title: 'Princess Mononoke'),
        WatchStep(order: 5, title: 'Spirited Away'),
        WatchStep(order: 6, title: 'Howl\'s Moving Castle'),
        WatchStep(order: 7, title: 'The Secret World of Arrietty',
            isOptional: true),
        WatchStep(order: 8, title: 'The Boy and the Heron', isOptional: true),
      ],
    ),
    SeriesOrder(
      id: 'mobpsycho',
      name: 'Mob Psycho 100',
      short: 'Psychic slice-of-life action',
      blurb: 'Short and self-contained — watch the three seasons in order.',
      orderType: 'Season order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'Mob Psycho 100'),
        WatchStep(order: 2, title: 'Mob Psycho 100 II'),
        WatchStep(order: 3, title: 'Mob Psycho 100 III'),
      ],
    ),
    SeriesOrder(
      id: 'oregairu',
      name: 'My Teen Romantic Comedy',
      short: 'Oregairu',
      blurb: 'Character drama across three seasons; watch them in order.',
      orderType: 'Season order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'My Teen Romantic Comedy SNAFU'),
        WatchStep(order: 2, title: '... SNAFU Too!'),
        WatchStep(order: 3, title: '... SNAFU Climax!', note: 'Finale.'),
      ],
    ),
    SeriesOrder(
      id: 'steinsgate',
      name: 'Steins;Gate',
      short: 'Time-travel thriller',
      blurb:
          'Watch the original series before its alternate-side sequel and the '
          'special.',
      orderType: 'Release order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'Steins;Gate'),
        WatchStep(
            order: 2,
            title: 'Steins;Gate: Egoistic Poriomania',
            note: 'OVA.',
            isOptional: true),
        WatchStep(order: 3, title: 'Steins;Gate: Load Region of Déjà Vu',
            note: 'Movie.'),
        WatchStep(order: 4, title: 'Steins;Gate 0',
            note: 'Alternate side story.'),
      ],
    ),
    SeriesOrder(
      id: 'evangelion',
      name: 'Neon Genesis Evangelion',
      short: 'TV series and rebuild films',
      blurb:
          'Start with the TV series, then its ending film, then the Rebuild '
          'quadrilogy as a separate retelling.',
      orderType: 'Release order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'Neon Genesis Evangelion (TV)'),
        WatchStep(order: 2, title: 'The End of Evangelion',
            note: 'Alternative TV ending.'),
        WatchStep(order: 3, title: 'Evangelion: 1.0 You Are (Not) Alone',
            note: 'Rebuild arc.'),
        WatchStep(order: 4, title: 'Evangelion: 2.0 You Can (Not) Advance'),
        WatchStep(order: 5, title: 'Evangelion: 3.0 You Can (Not) Redo'),
        WatchStep(order: 6, title: 'Evangelion: 3.0+1.0 Thrice Upon a Time'),
      ],
    ),
    SeriesOrder(
      id: 'gatari-films',
      name: 'Naruto',
      short: 'Main story, minimal filler',
      blurb:
          'The main story with the notable filler stretches flagged so you can '
          'skip them if you like.',
      orderType: 'Story order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'Naruto', note: 'Skip filler arcs if desired.'),
        WatchStep(order: 2, title: 'Naruto the Movie: Ninja Clash in the Land of Snow',
            isOptional: true),
        WatchStep(order: 3, title: 'Naruto Shippuden'),
        WatchStep(order: 4, title: 'Naruto Shippuden films',
            note: 'Largely stand-alone.', isOptional: true),
        WatchStep(order: 5, title: 'The Last: Naruto the Movie',
            note: 'After the main story.'),
        WatchStep(order: 6, title: 'Boruto: Naruto Next Generations',
            note: 'Sequel series.', isOptional: true),
      ],
    ),
    SeriesOrder(
      id: 'haruhi-films',
      name: 'Attack on Titan',
      short: 'TV seasons and finale specials',
      blurb:
          'Adapted as continuous seasons; the final chapters were released as '
          'special-length episodes.',
      orderType: 'Season order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'Season 1'),
        WatchStep(order: 2, title: 'Season 2'),
        WatchStep(order: 3, title: 'Season 3 Part 1'),
        WatchStep(order: 4, title: 'Season 3 Part 2'),
        WatchStep(order: 5, title: 'The Final Season Part 1'),
        WatchStep(order: 6, title: 'The Final Season Part 2'),
        WatchStep(order: 7, title: 'The Final Season: Final Chapters',
            note: 'Concluding specials.'),
      ],
    ),
    SeriesOrder(
      id: 'frieren',
      name: 'Frieren',
      short: 'Beyond Journey\'s End',
      blurb: 'A single continuous season so far; watch it straight through.',
      orderType: 'Season order',
      steps: <WatchStep>[
        WatchStep(order: 1, title: 'Frieren: Beyond Journey\'s End'),
        WatchStep(
            order: 2,
            title: 'Season 2 (upcoming)',
            note: 'Announced continuation.',
            isOptional: true),
      ],
    ),
  ];

  /// Every step across every series (used for stats/testing).
  static int get totalSteps =>
      series.fold<int>(0, (int sum, SeriesOrder s) => sum + s.stepCount);
}
