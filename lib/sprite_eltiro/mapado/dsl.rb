require 'mapado_dsl'

module SpriteEltiro
  module Mapado
    class Dsl < MapadoDsl
      def mapi_vortoj(vortoj)
        vortoj.each do |v|
          kun_ss = v.to_s
          sen_ss = kun_ss.chars.map do |c|
            case c
            when ?ĉ then 'cx'
            when ?Ĉ then 'Cx'
            when ?ĝ then 'gx'
            when ?Ĝ then 'Gx'
            when ?ĥ then 'hx'
            when ?Ĥ then 'Hx'
            when ?ĵ then 'jx'
            when ?Ĵ then 'Jx'
            when ?ŝ then 'sx'
            when ?Ŝ then 'Sx'
            when ?ŭ then 'ux'
            when ?Ŭ then 'Ux'
            else c
            end
          end.join
          mapi sen_ss, kun_ss
        end
      end
    end
  end
end
