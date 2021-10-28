function linmix_metro_update, logpost_new, logpost_old, seed, log_jrat

lograt = logpost_new - logpost_old

if n_elements(log_jrat) gt 0 then lograt = lograt + log_jrat

accept = 0

if lograt gt 0 then accept = 1 else begin
    
    u = randomu(seed)

    if alog(u) le lograt then accept = 1
    
endelse

return, accept
end
