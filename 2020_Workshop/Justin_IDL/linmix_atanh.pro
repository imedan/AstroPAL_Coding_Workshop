function linmix_atanh, x

z = 0.5d * ( alog(1 + x) - alog(1 - x) )

return, z
end
