require 'pry'
require_relative 'mood_logic'
require_relative 'config'

# natural notes (7)
def natural_notes
  @natural_notes ||= begin
    natural_notes = ("A".."G").to_a
    puts "* generating natural_notes: #{natural_notes}" if DEBUG

    natural_notes
  end
end

# all notes (12)
  # add sharps only for now (v2 can have flats)
  # will choose keys that work with this ...
def all_notes
  @all_notes ||= begin
    all_notes = []
    natural_notes.each do |note|
      all_notes << note
      all_notes << note + "#" unless note == "B" or note == "E"
      all_notes
    end

    puts "* generating all_notes: #{all_notes}" if DEBUG

    all_notes
  end
end

# major scale
def major_scale(root_note)
  major_scale = []
  current_note_index = all_notes.index(root_note)

  if DEBUG
    puts "* * * * * * * * * * * * * * * * * * * * * * * * "
    puts " generating #{root_note} major scale "
    puts "* * * * * * * * * * * * * * * * * * * * * * * * "
  end

  whole = 2
  half = 1
  [whole, whole, half, whole, whole, whole, half].each do |next_major_scale_step|
    # get the note for the current index
    note_of_scale = all_notes[current_note_index]
    puts "... current note: #{note_of_scale}" if DEBUG

    # save note in our new array
    major_scale << note_of_scale

    # move to next note ... but, make sure not at end of scale
    puts "   ... moving #{next_major_scale_step} steps" if DEBUG
    next_major_scale_step.times do
      current_note_index += 1
      puts "     ... #{all_notes[current_note_index]}" if DEBUG
      current_note_index = 0 if all_notes[current_note_index].nil?
    end
  end

  major_scale
end

def basic_chords_for(major_scale)
  major_scale.map.with_index do |scale_letter, i|
    scale_number = i + 1

    # Major
    if [1,4,5].include?(scale_number)
      chord_type = 'major'
      chord_label = ''
    end

    # Minor
    if [2,3,6].include?(scale_number)
      chord_type = 'minor'
      chord_label = 'm'
    end

    # Diminished
    if 7 == scale_number
      chord_type = 'diminished'
      chord_label = 'dim'
    end

    {
      scale_number: scale_number,
      scale_letter: scale_letter,
      chord_type: chord_type,
      chord_label: chord_label,
      chord_num: ROMANS[scale_number]
    }
  end
end

def song_parts_with_chords(chords_for_scale)
  chords = chords_for_scale.map{|c| "#{c[:scale_letter]}#{c[:chord_label]} (#{c[:chord_num]})"}

  # do not allow diminished unless configured
  chords.pop unless ALLOW_DIMINISHED

  song_parts = [ 'intro',
                 'verse',
                 'chorus',
                 'bridge',
                 'outro' ]

  song_parts.map do |song_part|
      {
        song_part: song_part,
        chords: (1..NUM_CHORDS_PER_PART).to_a.sample.times.map{ chords.sample }
      }
  end
end

def song_for_key_of(key)
  dashes = "- " * 30

  puts dashes
  puts "Key of #{key}"
  song_parts_with_chords(basic_chords_for(major_scale(key))).each do |song_part_with_chords|
    print "#{song_part_with_chords[:song_part]}: "
    puts song_part_with_chords[:chords].join(" | ")
  end
  puts dashes
end

# Accept keys as input
keys = ARGV.empty? ? ['C'] : ARGV
keys.each {|key| song_for_key_of(key) }

