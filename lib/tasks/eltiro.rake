require 'i18n_eltiro'

def desc_eltiro_i18n(kio)
  desc "Generas lokaĵoj el tradukoj de kurso-desktop (#{kio})"
end

namespace :eltiro do
  desc_eltiro_i18n "ĉiuj lokaĵoj"
  task 'i18n' => :environment do
    I18nEltiro::Konvertilo.new.konverti
  end

  desc_eltiro_i18n "elpurigo"
  task 'i18n:elpurigo' => :environment do
    I18nEltiro::Konvertilo.new(nur: %i[eo], eliga: %i[yml ai], sinsekva: true).konverti
  end

  I18nEltiro.lingvoj.except(:eo).keys.each do |lokaĵo|
    desc_eltiro_i18n ":eo, :#{lokaĵo}"
    task "i18n:#{lokaĵo}" => :environment do
      I18nEltiro::Konvertilo.new(nur: [:eo, lokaĵo], eliga: %i[yml ai]).konverti
    end
  end
end
