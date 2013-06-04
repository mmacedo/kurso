def redakti_dosieron(pado)
  linioj = IO.readlines(pado)
  yield(linioj)
  File.open(pado, 'w') do |dosiero|
    dosiero.puts linioj
  end
end

def ripari_spacojn(teksto)
  linioj = teksto.lines
  forigi_finajn_spacojn!(linioj)
  certigi_novan_linon_ĉe_eof!(linioj)
  linioj.join("\n")
end

def forigi_finajn_spacojn!(linioj)
  linioj.map! do |linio|
    linio.gsub(/[[:space:]]*$/, '')
  end
end

def certigi_novan_linon_ĉe_eof!(linioj)
  linioj[-1] = linioj[-1].chomp + "\n"
end
