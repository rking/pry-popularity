# encoding: utf-8
class PryPopularity
  Pry::Commands.create_command 'pry-popularity' do
    description 'Sort pry input history by frequency of use'
    command_options :requires_gem => 'jist', :keep_retval => true

    def options opt
      opt.on :g, :gist, 'Gist the result'
    end

    def process
      # TODO accept arg for other file
      lines = File.readlines Pry.config.history.file
      popularity = Hash.new 0
      $stderr.print <<-EOT
Found #{lines.size} history lines, scoring (each dot is 100 lines):
      EOT
      cache = {}
      count = 0
      lines.map do |e|
        # TODO convert this to a Hash instead, so we can extract
        # more info (at some point)
        thing = cache[e]
        unless thing
          thing = cache[e] =
            if cmd = _pry_.commands.find_command(e)
              cmd.match
            else
              '[ruby code]'
            end
          end
        popularity[thing] += 1
        count += 1
        if 0 == count % 100
          $stderr.print '.'
        end
      end
      $stderr.puts

      report = ''
      popularity.sort_by{|k,v| v}.each do |thing, score|
        report += "#{score} × #{thing}\n"
      end
      output.puts report

      if opts.present? :gist
        require 'jist'
        res = Jist.gist report, :filename => 'pry-popularity'
        output.puts 'Gisted at ' + res['html_url']
      else
        warn '(Note that you can run with -g, A.K.A. --gist)'
      end
      bangs = '!' * rand(4)
      "You're a cool guy"+bangs
    end
  end
end
