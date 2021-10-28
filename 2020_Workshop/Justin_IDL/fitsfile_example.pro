pro fitsfile_example

; example of reading in and plotting the SDSS filter curves
; and responses from a fits file

; for readfits, see https://idlastro.gsfc.nasa.gov/ftp/pro/fits/readfits.pro
; for mrdfits, see https://idlastro.gsfc.nasa.gov/ftp/pro/fits/mrdfits.pro

x = readfits('filter_curves.fits',h) ; header of fits file assigned to variable h
print,h ; print the header to see how everything is formatted

; this fits file seems to be formatted differently than readfits is
; used to reading (this happens a lot with old fits files in astronomy)
; so, we'll be using mrdfits to analyze and plot the data

u = mrdfits('filter_curves.fits',1)
g = mrdfits('filter_curves.fits',2)
r = mrdfits('filter_curves.fits',3)
i = mrdfits('filter_curves.fits',4)
z = mrdfits('filter_curves.fits',5)

; according to the header information, the wavelengths and filter responses
; arrays are stored in 'wavelength' and 'respt', so let's plot them!

loadct,39   ; load colortable, 0 = black, 40 = blue, 80 = cyan, 120 = green, 200 = orange, 250= red
; for more color tables, visit https://www.harrisgeospatial.com/docs/LoadingDefaultColorTables.html
!p.background=255
!p.color=0
!p.charsize=1.7
;!p.font=0

device,decomposed=0

set_plot,'ps'
device,filename='sdss_filters.ps',bits=8,/color

     plot,u.wavelength,u.respt,ythick=2,xthick=2,xrange=[2500,11000],yrange=[0,0.6],$
        xtit = 'Wavelength',ytit='Filter Response'
     oplot,g.wavelength,g.respt,color=40
     oplot,r.wavelength,r.respt,color=120
     oplot,i.wavelength,i.respt,color=250
     oplot,z.wavelength,z.respt,color=80

!p.color=255
!p.background=0
!p.charsize=1.0
!p.font=3
device,/close

end
