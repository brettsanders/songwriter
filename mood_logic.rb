# Moods in happiness from miserable (all minor) diminished to campfire

MOOD_LOGIC = {
  miserable: {
    chords: { maj: 0,  min: 3,  dim: 1 },
    rules:  { }
  },

  depressing: {
    chords: { maj: 1,  min: 2,  dim: 1 },
    rules:  { start_with: { min: 2 } }
  },

  sad: {
    chords: { maj: 2,  min: 3,  dim: 1 },
    rules:  { start_with: { min: 1 } }
  },

  mix: {
    chords: { maj: 3, min: 3, dim: 1 },
    rules:  { start_with: { maj: 1, min: 1 } }
  },

  happy: {
    chords: { maj: 3, min: 2, dim: 1 },
    rules:  { start_with: { maj: 1 } }
  },

  bright: {
    chords: { maj: 3, min: 1, dim: 0 },
    rules:  { start_with: { maj: 2 } }
  },

  campfire: {
    chords: { maj: 3, min: 0, dim: 0 },
    rules:  { }
  }
}