/// Here are coordinates of all of the lakes in the game

const _outerBorderSize = 70;
const w = 50;

List<List<num>> lakes_verteces = <List<num>>[
  // Outer border top
  <num>[
    // t0
    _outerBorderSize, 0, -_outerBorderSize,
    _outerBorderSize, 0, -w,
    -_outerBorderSize, 0, -w,
    // t1
    -_outerBorderSize, 0, -_outerBorderSize,
    _outerBorderSize, 0.0, -_outerBorderSize,
    -_outerBorderSize, 0.0, -w,
  ],
  // Outer border right
  <num>[
    // t0
    _outerBorderSize, 0, -_outerBorderSize,
    _outerBorderSize, 0, _outerBorderSize,
    w, 0, -_outerBorderSize,
    // t1
    w, 0, -_outerBorderSize,
    w, 0, _outerBorderSize,
    _outerBorderSize, 0, _outerBorderSize,
  ],
  // Outer border left
  <num>[
    // t0
    -_outerBorderSize, 0, _outerBorderSize,
    -_outerBorderSize, 0, -_outerBorderSize,
    -w, 0, _outerBorderSize,
    // t1
    -w, 0, _outerBorderSize,
    -w, 0, -_outerBorderSize,
    -_outerBorderSize, 0, -_outerBorderSize,
  ],
  // Outer border bottom
  <num>[
    // t0
    -_outerBorderSize, 0, _outerBorderSize,
    -_outerBorderSize, 0, w,
    _outerBorderSize, 0, w,
    // t1
    _outerBorderSize, 0, _outerBorderSize,
    -_outerBorderSize, 0.0, _outerBorderSize,
    _outerBorderSize, 0.0, w,
  ],
  // Lake 0
  <num>[
    // t0
    -w, 0, -w,
    -25, 0, -w,
    -w, 0, 25,
  ],
];

List<List<num>> lakes_textureCoords = <List<num>>[
  // Outer border top
  <num>[
    // t0
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
    // t1
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
  ],
  // Outer border right
  <num>[
    // t0
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
    // t1
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
  ],
  // Outer border left
  <num>[
    // t0
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
    // t1
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
  ],
  // Outer border bottom
  <num>[
    // t0
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
    // t1
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
  ],
  // Lake 0
    <num>[
    // t0
    0.0, 0.0,
    1.0, 0.0,
    1.0, 1.0,
    0.0, 1.0,
  ],
];
