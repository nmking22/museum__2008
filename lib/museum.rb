class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    recommended_exhibits = []
    @exhibits.each do |exhibit|
      if patron.interests.include? exhibit.name
        recommended_exhibits << exhibit
      end
    end
    recommended_exhibits
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    interested_patrons = Hash.new
    @exhibits.each do |exhibit|
      interested_patrons[exhibit] = []
      @patrons.each do |patron|
        if patron.interests.include? exhibit.name
          interested_patrons[exhibit] << patron
        end
      end
    end
    interested_patrons
  end

  def ticket_lottery_contestants(exhibit)
    @lottery_contestants = patrons_by_exhibit_interest[exhibit].find_all do |patron|
      patron.spending_money <= exhibit.cost
    end
    @lottery_contestants
  end

  def draw_lottery_winner(exhibit)
    if @lottery_contestants == nil
      nil
    else
      lottery_winner = @lottery_contestants.sample
      @lottery_contestants = nil
      lottery_winner.name
    end
  end
end
