pro linmix_test

	x=findgen(100)
	y=findgen(100)
	xerr=make_array(100,value=4)
	yerr=make_array(100,value=8)
	;xerr=10*randomu(seed,1000)
	;yerr=10*randomu(seed,1000)

	;linmix_err,x,y,post,xsig=xerr,ysig=yerr,/metro
	;print,post[0],post[1],post[2],post[3],post[4],post[5],$
;		post[6],post[7],post[8],post[9],post[10],post[11]

	yfit=1.0060245*x+1.0064609

	device,decomposed=0
	loadct,39
	plot,x,y,psym=3
	oploterror,x,y,xerr,yerr,psym=3	
	oplot,x,yfit,color=250
end
