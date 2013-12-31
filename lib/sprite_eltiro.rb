require 'sprite_eltiro/mapado'

module SpriteEltiro
  class Konvertilo
    include Mapado

    ENIGA_PADO = "vendor/kurso-desktop/sonoj"
    ELIGA_PADO = "tmp/audio"

    def initialize
      @eniga = Rails.root.join(ENIGA_PADO)
      @eliga = Rails.root.join(ELIGA_PADO)
    end

    def eniga_dosiernomoj_arbo
      eniga_ŝablono = Regexp.quote(@eniga.to_s)

      Dir.glob(@eniga.join("**/*.ogg")).reduce(Hash.new) do |arbo, dosiero|
        if m = dosiero.downcase.match(%r{^#{eniga_ŝablono}(/(lec[01][0-9]))?/(\w+)\.ogg})
          dosierujo  = m[2]
          dosiernomo = m[3]
          plena_pado = m[0]
          (arbo[dosierujo] ||= Hash.new)[dosiernomo] = plena_pado
        else
          raise "Dosiero nomo aŭ formato nekonata!"
        end
        arbo
      end
    end

    def konverti
      eniga, eliga = eniga_dosiernomoj_arbo, Hash.new
      kuri_mapojn! eniga, eliga

      eliga.each do |k, leciono|
        celloko = @eliga.join(k)
        sonoj = leciono.values.map { |hash| hash.values }.flatten.uniq
        yield(k, sonoj.to_a[0..1])
      end
    end
  end
end
