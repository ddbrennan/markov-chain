class MarkovChain

  attr_accessor :word_array, :enders

  def initialize(input)
    # Initialize with an array of the inputted words, and
    # an array of words found at the end of those sentences.
    text_file = File.read(input)
    @word_array = text_file.downcase.gsub(/[^a-z0-9\-\s]/i, '').split
    @enders = find_enders(text_file)
  end

  def make_sentence(num = rand(8..16))
    # Generate an 8-16 word sentence by running our "find_next", capitalizing
    # the first word and appending a word we know can end a sentence.
    sentence = num.times.map do
      word = find_next(word)
      word
    end
    sentence[0] = sentence[0].capitalize
    "#{sentence.join(" ")} #{self.enders.sample}"
  end

  def make_paragraph(num = rand(4..8))
    # Create 4-8 sentences to create a paragraph.
    num.times.map do
      make_sentence
    end.join(" ")
  end

  def make_essay(num = 5)
    # Create 5 paragraphs to form an essay
    num.times.map do
      make_paragraph
    end
  end

  private

  def find_next(target)
    # Search our array of all words for the inputted word and map an array
    # of all words that follow it. If nothing is found a random word is picked.
    next_words = word_array.each_with_index.map do |word, index|
      word_array[index + 1] if word == target && word_array[index + 1]
    end.compact
    next_words.empty? ? word_array.sample : next_words.sample
  end

  def find_enders(input)
    # All words that end with a period are selected as possible sentence enders.
    input.split.select do |word|
      word.end_with? "."
    end
  end

end
