# encoding: utf-8
class PryPopularity
  Pry::Commands.create_command 'pry-popularity' do
    description 'Sort pry input history by frequency of use'

    def process
      # TODO accept arg for other file
      lines = File.readlines Dir.home + '/.pry_history'
      popularity = Hash.new 0
      $stderr.print <<-EOT
Found #{lines.size} history lines, scoring (each dot is 100 lines):
      EOT
      count = 0
      lines.map do |e|
        # TODO convert this to a Hash instead, so we can extract
        # more info (at some point)
        thing =
          if cmd = _pry_.commands.find_command(e)
            cmd.match
          else
            'ruby code'
          end
        popularity[thing] += 1
        count += 1
        if 0 == count % 100
          $stderr.print '.'
        end
      end
      $stderr.puts

      popularity.sort_by{|k,v| v}.each do |thing, score|
        output.puts "#{score} × #{thing}"
      end
    end
  end
end
