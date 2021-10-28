function sunsymbol, FONT=font

On_error,2
compile_opt idl2

if N_elements(font) eq 0 then font = !p.font
if (font EQ -1) then return,'!D!9n!N!X' else $
if (!D.NAME NE 'PS')  then return,'!DSun!N' else begin

;Since 8.2 we can use !10 to select DejaVuSans font and then use the
;unicode Sun symbol
if FONT EQ 1 then $
   if (!VERSION.RELEASE GE '8.2') then return,'!10!D!Z(2609)!X!N' else $
   return,'!D!Z(2609)!X!N'
;Want to use /AVANTGARDE,/BOOK which is the default font 17, but to make sure
;that ISOLATIN encoding is turned off, we'll define our own font.

 device,/AVANTGARDE,/BOOK,ISOLATIN=0,FONT_INDEX = 20

 return, '!20!S!DO!R!I ' + string(183b) + '!X!N'
endelse

end
