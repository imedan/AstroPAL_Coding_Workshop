pro fitting_funcs

;generate random data
x = findgen(11,start=0,increment=1)
y = fltarr(n_elements(x))

for i = 0,n_elements(x)-1 do begin
    y[i] = i + 1.*randomu(seed,1)
endfor

z = findgen(100,start=-50,increment=1)

;generate errors for each variable, in this case, a random number between 0 and 1
;for each value in the array
xerr = randomu(seed,11)
yerr = randomu(seed,11)

;linfit is a linear regression with errors in only 1 direction.
;linfit's output is y = b + mx, so b is the 1st element of result, m is the 2nd
result = linfit(x, y, measure_errors=yerr, sigma=sigma)
fit1 = result[0] + result[1]*z
print,'linfit: y = ',result[1],' +/-',sigma[1],' x + ',result[0],' +/-',sigma[0]
print,''

;fitexy is a linear regression with errors in both directions
;fitexy's output is the same as linfit
fitexy, x, y, b, m, x_sig = xerr, y_sig = yerr, sigma_A_B
fit2 = b + m*z
print,'fitexy: y = ',m,' +/-',sigma_A_B[0],' x + ',b,' +/-',sigma_A_B[1]
print,''

;to be really fancy with linear fitting, use linmix_err: https://idlastro.gsfc.nasa.gov/ftp/pro/math/linmix_err.pro
    ;bayesian-style linear regression with errors in both directions and random scatter

linmix_err,x,y,post,xsig=xerr,ysig=yerr,/metro,/silent ;use metro if data size is small

;fetching the outputs of linmix_err, which are probability distributions for m, b, and scatter,
    ;then sorting the arrays in numerical order to brute-force-ly find median and 1-sigma scatter

constant_presort=sort(post.alpha)
constant_sort=post.alpha[constant_presort]
slope_presort=sort(post.beta)
slope_sort=post.beta[slope_presort]
sigma_presort=sort(post.sigsqr)
sigma_sort=post.sigsqr[sigma_presort]

constant = constant_sort[49999999]
slope = slope_sort[49999999]
sigma = sigma_sort[49999999]
sig_constant=constant_sort[49999999]-constant_sort[15899999]
sig_slope=slope_sort[49999999]-slope_sort[15899999]
sig_sigma=sigma_sort[49999999]-sigma_sort[15899999]

print,'Dat fit:'
print,'Alpha (constant):',constant,'+/-',sig_constant
print,'Beta (slope):',slope,'+/-',sig_slope
print,'Variance:',sigma,'+/-',sig_sigma
print,''

;multiple curve/polynomial fits for IDL, simplest is poly_fit which works almost the same;
    ;as linfit
;poly_fit's output is c + bx + ax^2
;full list of curve fitting: https://epics.anl.gov/bcda/dataVis/idl_html/CurvFitRef.html

x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
y = [0.25, 0.16, 0.09, 0.04, 0.01, 0.00, 0.01, 0.04, 0.09, $
   0.16, 0.25]
;after inputting the data arrays, denote the degree of the polynomial you
    ;are fitting. In this case, degree 2
result = poly_fit(x, y, 2, measure_errors = yerr, sigma=sigma)
fit3 = result[0] + result[1]*z + result[2]*z^(2.)

print,'poly_fit: y = ',result[0],' +/-',sigma[0],result[1],' +/-',sigma_A_B[1],' x',result[2],' +/-',sigma[2],' x^2'
print,''

end
