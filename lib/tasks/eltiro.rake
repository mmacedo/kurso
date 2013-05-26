require 'i18n_eltiro'
require 'whitespace_utils'

def desc_eltiro_i18n(kio)
  desc "Generas lokaĵaroj el tradukoj el kurso-desktop (#{kio})"
end

namespace :eltiro do
  desc "Printi difektoj en la tradukoj el kurso-desktop"
  task 'i18n:difektoj' => :environment do
    I18nEltiro::Konvertilo.new.printi_difektoj
  end

  desc_eltiro_i18n "ĉiuj lokaĵaroj"
  task 'i18n' => :environment do
    I18nEltiro::Konvertilo.new.konverti
    lokaĵaroj = "config/locales/lecionoj/{aliaj,leciono??}/*.??.yml"
    Dir.glob(Rails.root.join(lokaĵaroj)).each do |dosiero|
      redakti_dosiero(dosiero) do |linioj|
        forigi_finajn_spacojn! linioj
        certigi_novan_linon_ĉe_eof! linioj
      end
    end
  end

  desc_eltiro_i18n ":eo kaj parametroj"
  task "i18n:nur", (?a..?e).to_a => :environment do |t, args|
    lokaĵaroj = [:eo] + args.to_hash.values.map { |s| s.to_sym }
    I18nEltiro::Konvertilo.new(nur: lokaĵaroj, eliga: %i[yml ai], sinsekva: true).konverti
  end
end
