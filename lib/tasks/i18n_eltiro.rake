require 'i18n_eltiro'

def desc_i18n_eltiro(kio)
  desc "Generas lokaĵarojn el tradukoj el kurso-desktop (#{kio})"
end

namespace :eltiro do
  desc "Printi difektojn en la tradukoj el kurso-desktop"
  task 'i18n:difektoj' => :environment do
    I18nEltiro::Konvertilo.new.printi_difektoj
  end

  desc_i18n_eltiro "ĉiuj lokaĵaroj"
  task 'i18n' => :environment do
    I18nEltiro::Konvertilo.new.konverti
  end

  desc_i18n_eltiro ":eo kaj parametroj"
  task "i18n:nur", (?a..?e).to_a => :environment do |t, args|
    lokaĵaroj = [:eo] + args.to_hash.values.map { |s| s.to_sym }
    I18nEltiro::Konvertilo.new(nur: lokaĵaroj, eliga: %i[yml ai], sinsekva: true).konverti
  end
end
