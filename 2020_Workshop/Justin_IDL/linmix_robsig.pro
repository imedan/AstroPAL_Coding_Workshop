function linmix_robsig, x

nx = n_elements(x)
                                ;get inter-quartile range of x
sorted = sort(x)
iqr = x[sorted[3 * nx / 4]] - x[sorted[nx / 4]]
sdev = stddev(x, /nan)
sigma = min( [sdev, iqr / 1.34] ) ;use robust estimate for sigma
if sigma eq 0 then sigma = sdev

return, sigma
end
