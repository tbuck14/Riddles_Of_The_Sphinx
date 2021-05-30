require 'riddle'
require 'rspec'


describe('#Riddle') do

  before(:each) do
    Riddle.clear()
  end

  describe ('.all') do
    it ('returns an empty array when there are no riddles') do
      expect(Riddle.all).to(eq([]))
    end
  end

  describe ('#save') do
      it ('saves a riddle') do
        riddle1 = Riddle.new('riddle1', 'the riddle1', 'answer1', nil)
        riddle1.save()
        riddle2 = Riddle.new('riddle2', 'the riddle2', 'answer2', nil)
        riddle2.save()
        expect(Riddle.all).to(eq([riddle1, riddle2]))
      end
  end
  
  describe ('#guess') do
    it ('compares a guess to a riddle to the actual answer and returns true if the guess is correct regardless of case or spaces') do
      riddle1 = Riddle.new('riddle1', 'the riddle1', 'answer1', nil)
      riddle1.save()
      expect(riddle1.guess('AnsWeR1  ')).to(eq(true))
    end
  end

  describe ('.find') do
    it ('returns a specific riddle matched to an id') do
      riddle1 = Riddle.new('riddle1', 'the riddle1', 'answer1', nil)
      riddle1.save()
      riddle2 = Riddle.new('riddle2', 'the riddle2', 'answer2', nil)
      riddle2.save()
      expect(Riddle.find(riddle2.id)).to(eq(riddle2))
    end
  end

  describe ('#==') do
    it ('compares equality based on name, riddle, and answer') do
      riddle1 = Riddle.new('riddle1', 'the riddle1', 'answer1', nil)
      riddle1.save()
      riddle2 = Riddle.new('riddle1', 'the riddle1', 'answer1', nil)
      riddle2.save()
      expect(riddle1).to(eq(riddle2))
    end
  end

  describe ('#update') do
    it ('updates the name, riddle, and andswer') do
      riddle2 = Riddle.new('riddle2', 'the riddle2', 'answer2', nil)
      riddle2.save()
      riddle2.update('name','riddle','answer')
      expect(riddle2.name).to(eq('name'))
      expect(riddle2.riddle).to(eq('riddle'))
      expect(riddle2.answer).to(eq('answer'))
    end
  end

  describe ('#delete') do
    it ('deletes a riddle') do
      riddle2 = Riddle.new('riddle2', 'the riddle2', 'answer2', nil)
      riddle2.save()
      riddle2.delete
      expect(Riddle.all).to(eq([]))
    end
  end

end