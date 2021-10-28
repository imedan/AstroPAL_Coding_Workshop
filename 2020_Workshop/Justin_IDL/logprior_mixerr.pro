function logprior_mixerr, mu, mu0, tausqr, usqr, wsqr

ngauss = n_elements(mu)

if ngauss gt 1 then begin

    logprior_mu = -0.5 * alog(usqr) - 0.5 * (mu - mu0)^2 / usqr
    logprior_mu = total(logprior_mu)
    
    logprior_tausqr = 0.5 * alog(wsqr) - 1.5 * alog(tausqr) - 0.5 * wsqr / tausqr
    logprior_tausqr = total(logprior_tausqr)

    logprior = logprior_mu + logprior_tausqr

endif else logprior = 0d ;if ngauss = 1 then uniform prior

return, logprior
end
