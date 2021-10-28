pro linmix_metro_results, arate, ngauss

print, ''
print, 'Metropolis-Hastings Acceptance Rates:'

print, '(ALPHA, BETA) : ' + strtrim(arate[0], 1)
print, 'SIGMA^2 : ' + strtrim(arate[1], 1)
print, ''
for k = 0, ngauss - 1 do begin

    print, 'GAUSSIAN ' + strtrim(k+1,1)
    print, '   MEAN : ' + strtrim(arate[2+k], 1)
    print, '   VARIANCE : ' + strtrim(arate[2+k+ngauss], 1)

endfor

if ngauss gt 1 then begin

    print, ''
    print, 'Mu0 : ' + strtrim(arate[2+2*ngauss], 1)
    print, 'u^2 : ' + strtrim(arate[3+2*ngauss], 1)
    print, 'w^2 : ' + strtrim(arate[4+2*ngauss], 1)

endif

print, ''

return
end
