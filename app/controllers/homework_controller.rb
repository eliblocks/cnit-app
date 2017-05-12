class HomeworkController < ApplicationController

  def hint
    @query = params[:q].downcase
    @names = names
    @hits = hits
    render json: { names: @hits}
  end

  def dates
    @date = Date.today
    @long_date = long_date
    @short_date = short_date
    @time = Time.now.strftime("%l:%M %p")
    render json: { time: @time, short_date: @short_date, long_date: @long_date }
  end

  def poll

    if params[:vote] == '0'
      @vote = true
    elsif params[:vote] == '1'
      @vote = false
    end

    Vote.create!(vote: params[:vote])
    @yes_count = Vote.where(vote: true).count
    @no_count = Vote.where(vote: false).count
    render json: { yes_count: @yes_count, no_count: @no_count }
  end

  def state_info
    @abbr = params[:abbr].upcase
    @state = states.find { |state| state[0] == @abbr }
    if @state
      @state_name = @state[1]
      @capital = @state[2]
      @population = @state[3]
      render json: { stateName: @state_name, capital: @capital, population: @population }
    else
      @msg = "state code error"
      render json: { stateName: @msg, capital: @msg, population: @msg }
    end
  end

  def states
    [['AL',  'Alabama', 'Montgomery',  4369862],
    ['AK',  'Alaska',  'Juneau',  619500],
    ['AZ',  'Arizona', 'Phoenix', 4778332],
    ['AR',  'Arkansas',  'Little Rock', 2551373],
    ['CA',  'California',  'Sacramento',  3145121],
    ['CO'  'Colorado',  'Denver',  405613]]
  end

  def names
    [
      "Anna",
      "Brittany",
      "Cinderella",
      "Diana",
      "Eva",
      "Fiona",
      "Gunda",
      "Hege",
      "Inga",
      "Johanna",
      "Kitty",
      "Linda",
      "Mary",
      "Nina",
      "Ophelia",
      "Petunia",
      "Amanda",
      "Raquel",
      "Cindy",
      "Doris",
      "Eve",
      "Evita",
      "Sunniva",
      "Tove",
      "Unni",
      "Violet",
      "Vicky",
      "Liza",
      "Elizabeth",
      "Ellen",
      "Wanda",
      "Wenche",
      "Xandra",
      "Yaffa",
      "Zelda"
    ]
  end

  def hits
    @names.select{ |name| name.downcase.start_with?(@query) }
  end

  def long_date
    @date.strftime("%d %B, %Y")
  end

  def short_date
    @date.strftime("%m/%d/%y")
  end

end
