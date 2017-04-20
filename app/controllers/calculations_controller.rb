class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    # Word count
    text_split_into_array = @text.gsub(/[^a-z0-9\s]/i, "").downcase.split
    @word_count = text_split_into_array.length

    # Character count
    characters_split_into_array = @text.chars
    number_of_spaces = @text.count(' ')

    @character_count_with_spaces = characters_split_into_array.length
    @character_count_without_spaces = characters_split_into_array.length - number_of_spaces

    # Occurence count
    special_word_downcase = @special_word.downcase

    @occurrences = text_split_into_array.count(special_word_downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    r = @apr.to_f / 100 / 12
    p = @principal.to_f
    n = @years * 12
    @monthly_payment = ( r / ( 1 - (1 + r) ** (-1 * n))) * p

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort_by(&:to_i)

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum
    len = @numbers.length
    sorted = @numbers.sort
    @median = len % 2 == 1 ? sorted[len/2] : (sorted[len/2 - 1] + sorted[len/2]).to_f / 2

    @sum = @numbers.sum

    @mean = @sum / @count

    squared_numbers = []

    @numbers.each do |num|
      square = (num - @mean) ** 2
      squared_numbers.push(square)
    end

    @variance = squared_numbers.sum / @count

    @standard_deviation = Math.sqrt(@variance)

    @mode = @numbers.max_by { |i| @numbers.count(i) }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
