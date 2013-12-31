require 'open3'
require 'sprite_eltiro'

def certigi_komandon_ekziston!(komando, mesaĝo)
  unless %x( which #{komando} ; echo "$?" ).lines.last.chomp == "0"
    red, reset = "\033[31m", "\033[0m"
    raise "#{red}Komando '#{komando}' ne trovita: #{mesaĝo}#{reset}"
  end
end

namespace :eltiro do
  desc "Generas aŭdio sprite pro lecionoj sonoj (klaki al aŭdi)"
  task 'sprite' => :environment do
    certigi_komandon_ekziston! 'ffmpeg', '`sudo apt-get install -y ffmpeg`'
    certigi_komandon_ekziston! 'node', 'https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager'
    audiosprite = Rails.root.join('vendor', 'audiosprite-generator', 'audiosprite.js').to_s
    SpriteEltiro::Konvertilo.new.konverti do |nomo, sonoj|
      system('node', audiosprite, '--output', nomo, '--export', 'm4a', "--log", "debug", *sonoj)
    end
  end
end
