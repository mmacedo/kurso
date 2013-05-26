def redakti_dosiero(pado)
  linioj = IO.readlines(pado)
  yield(linioj)
  File.open(pado, 'w') do |dosiero|
    dosiero.puts linioj
  end
end

def forigi_finajn_spacojn!(linioj)
  linioj.map! do |linio|
    linio.gsub(/[[:space:]]*$/, '')
  end
end

def certigi_novan_linon_ĉe_eof!(linioj)
  linioj[-1] = linioj[-1].chomp + "\n"
end
