module Function
    def validation(prompt, validation_regex, message, max_attempts)
      max_attempts.times do |attempt|
        puts prompt
        input = gets.chomp.strip

        if input =~ validation_regex
          return input
        else
          remaining_attempts = max_attempts - attempt - 1
          puts "#{message}"
        end
      end
      return nil
    end
  end