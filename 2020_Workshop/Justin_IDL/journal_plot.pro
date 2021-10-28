pro journal_plot

;generate random data
x = findgen(11,start=0,increment=1)
y1 = fltarr(n_elements(x))

;generate random 2nd data set
y2 = fltarr(n_elements(x))

for i = 0,n_elements(x)-1 do begin
    y1[i] = i + 1.*randomu(seed,1)
    y2[i] = i + 2.*randomu(seed,1)
endfor

;generate errors for each variable, in this case, a random number between 0 and 1
;for each value in the array
xerr = randomu(seed,11)
yerr1 = randomu(seed,11)
yerr2 = 0 + 2.*randomu(seed,11)

;fit both data sets with errors in y. linfit's output is y = b + mx
result1 = linfit(x, y1, measure_errors=yerr1)
result2 = linfit(x, y2, measure_errors=yerr2)

;assign functions to each fit
z = findgen(100,start=-50,increment=1)
fit1 = result1[0] + result1[1]*z
fit2 = result2[0] + result2[1]*z

loadct,39
!p.background=255
!p.color=0
!p.charsize=1.7
!p.font=0

;for plotting: sym.pro offers many other symbol choices than the IDL defaults.
;xyzthick changes the thickness of each axis, default is 1
;xs or ys=1 tells the graph to do *explicitly* what you're telling it to do when
    ;you set the ranges on the axes.
;textoidl allows you to input latex language into plot labels and legends
;oploterror plots error bars for each variable, and works like this:
    ;oploterror, variable1, variable2, variable1 errors, variable 2 errors
;always need to differentiate data in plots and fits. Color is one way (errcolor for error bars),
    ;different symbols, and different linestyles for fitting lines.
;always make things thicccer
;legends in IDL are a nightmare, so instead, use xyouts, which outputs strings
    ;onto specified regions of the plot, dictated by the data values on each axis

device,decomposed=0

set_plot,'ps'
device,filename='journal_plot.ps',bits=8,/color,/times

plot,x,y1,psym=sym(1),xrange=[-1.5,12.5],yrange=[-1.5,12.5],xthick=5,ythick=5,xs=1,ys=1,$
    xtit=textoidl("\alpha Values"),ytit=textoidl("\beta Values")
oploterror,x,y1,xerr,yerr1,psym=3,thick=3
oplot,x,y2,psym=sym(5),color=50
oploterror,x,y2,xerr,yerr2,psym=3,errcolor=50,thick=3
oplot,z,fit1,thick=5
oplot,z,fit2,thick=5,color=50,linestyle=2
oplot,[[0]],[[10]],psym=sym(1)
oplot,[[0]],[[9]],psym=sym(5),color=50
xyouts,0.5,9.8,'Data Set 1',chars=1.2
xyouts,0.5,8.8,'Data Set 2',chars=1.2

!p.color=255
!p.background=0
!p.charsize=1.0
!p.font=3
device,/close

end
