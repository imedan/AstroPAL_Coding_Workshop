pro bootstrap_ex

;using whatever measurement function, this computes a distribution of random
    ;measurements within specified windows, then computes the median of the
    ;resulting distribution, symmetric 1-sigma values, and asymmetric 1-sigma values

;for this simple example, we're going to be calling a function that multiplies
  ;two numbers together, 10 and 10
x = 10.
y = 10.
;left and rightblock specify the range of values lower than x and higher than y
    ;that can be randomly called. So if both are 1, the function can randomly call
    ;x to be anywhere between 9 and 10 and y to be anywhere between 10 and 11
leftblock = 1.
rightblock = 1.

;generating arrays of random numbers between x & y and left & rightblock
x = x-(leftblock*RANDOMU(Seed,10000))
y = y+(rightblock*RANDOMU(Seed,10000))

;z is the array we will dump our outputs into
z = fltarr(10000)

for i = 0,9999 do begin
    z[i] = multiply(x[i],y[i])
endfor

plothist,z

;calculate the median & standard deviation of the distribution built from our function
med_z = median(z)
sigma_z = sqrt(total((z-med_z)^2/(n_elements(z)-1)))

;symmetric error bars
print,''
print,'Symmetric Error Solution'
print,med_z,'   +/-',sigma_z
print,''

;asymmetric error bars
;sorting the distribution in order and choosing the median and 1-sigma uncertainty
;the numbers here correspond to 1 standard deviation as 68% away from the median
    ;in both directions
z_presort = sort(z)
z_sort = z[z_presort]
pos_sigma = z_sort[4999]-z_sort[1589]
neg_sigma = z_sort[8409]-z_sort[4999]
print,'Asymmetric Error Solution'
print,z[4999],'   +',pos_sigma,'   -',neg_sigma
print,''

end
