function loglik_mixerr, x, y, xvar, yvar, xycov, delta, theta, pi, mu, tausqr, Glabel

alpha = theta[0]
beta = theta[1]
sigsqr = theta[2]

nx = n_elements(x)
ngauss = n_elements(pi)

Sigma11 = dblarr(nx, ngauss)
Sigma12 = dblarr(nx, ngauss)
Sigma22 = dblarr(nx, ngauss)
determ = dblarr(nx, ngauss)

for k = 0, ngauss - 1 do begin

    Sigma11[0,k] = beta^2 * tausqr[k] + sigsqr + yvar
    Sigma12[0,k] = beta * tausqr[k] + xycov
    Sigma22[0,k] = tausqr[k] + xvar

    determ[0, k] = Sigma11[*,k] * Sigma22[*,k] - Sigma12[*,k]^2

endfor

det = where(delta eq 1, ndet, comp=cens, ncomp=ncens) ;any non-detections?

loglik = dblarr(nx)

if ndet gt 0 then begin
                                ;compute contribution to
                                ;log-likelihood from the detected
                                ;sources
    for k = 0, ngauss - 1 do begin
        
        gk = where(Glabel[det] eq k, nk)

        if nk gt 0 then begin

            zsqr = (y[det[gk]] - alpha - beta * mu[k])^2 / Sigma11[det[gk],k] + $
              (x[det[gk]] - mu[k])^2 / Sigma22[det[gk],k] - $
              2d * Sigma12[det[gk],k] * (y[det[gk]] - alpha - beta * mu[k]) * $
              (x[det[gk]] - mu[k]) / (Sigma11[det[gk],k] * Sigma22[det[gk],k])
            
            corrz = Sigma12[det[gk],k] / sqrt( Sigma11[det[gk],k] * Sigma22[det[gk],k] )
            
            loglik[det[gk]] = -0.5d * alog(determ[det[gk],k]) - 0.5 * zsqr / (1d - corrz^2)

        endif

    endfor

endif

if ncens gt 0 then begin
                                ;compute contribution to the
                                ;log-likelihood from the
                                ;non-detections
    for k = 0, ngauss - 1 do begin

        gk = where(Glabel[cens] eq k, nk)

        if nk gt 0 then begin
            
            loglikx = -0.5 * alog(Sigma22[cens[gk],k]) - $
              0.5 * (x[cens[gk]] - mu[k])^2 / Sigma22[cens[gk],k]
            
                                ;conditional mean of y, given x and
                                ;G=k
            cmeany = alpha + beta * mu[k] + Sigma12[cens[gk],k] / Sigma22[cens[gk],k] * $
              (x[cens[gk]] - mu[k])
                                ;conditional variance of y, given x
                                ;and G=k
            cvary = Sigma11[cens[gk],k] - Sigma12[cens[gk],k]^2 / Sigma22[cens[gk],k]

                                ;make sure logliky is finite
            logliky = alog(gauss_pdf( (y[cens[gk]] - cmeany) / sqrt(cvary) )) > (-1d300) 
            
            loglik[cens[gk]] = loglikx + logliky
        
        endif

    endfor
    
endif

loglik = total(loglik)

return, loglik
end
