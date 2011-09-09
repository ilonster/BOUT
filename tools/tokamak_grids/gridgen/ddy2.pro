FUNCTION ddy2, var, mesh, nmax=nmax, tol=tol
;
; Author:       Ilon Joseph
; Began:        2011/06/22
; Modified:     2011/06/24 
; 
; Takes y derivative on mesh
;
; Notes:
;       * mesh assumes uniform dtheta = 2*pi/npol
;
; Options: 
;       * chop filters the result


  v1 = 0.0*var
  v2 = 0.0*var

  dtheta = 2.*!PI / FLOAT(TOTAL(mesh.npol))

  status = gen_surface(mesh=mesh) ; Start generator


  REPEAT BEGIN
    yi = gen_surface(last=last, xi=xi, period=period)
    nyi = size(yi,/n_elements)
;    print, '[XI, NYI]=',xi, nyi
    nper = float(nyi)
    yf = float(yi)
        
    IF period THEN BEGIN
;       v1[xi,yi] = fft_deriv2(var[xi,yi],nmax=nmax,tol=tol)
       v1[xi,yi] = fft(deriv_fft1d(fft(var[xi,yi]),1), /inv)*(2.*!pi)/nper
;        v1[xi,yi] = fft(filter_fft1d(deriv_fft1d(fft(var[xi,yi]),1)),/inv)*(2.*!pi)/nper 

;       v1[xi,yi] = DERIV(var[xi,yi])

;       v2[xi,yi] = SPL_INIT(yf,var[xi,yi])
;       v1[xi,yi] = SPLDER(yf,var[xi,yi],v2[xi,yi])

;       v2[xi,yi] = SPLGEN(yf,var[xi,yi],period=nper)
;       v1[xi,yi] = SPLDER(yf,var[xi,yi],v2[xi,yi],period=nper)

    ENDIF ELSE BEGIN

        v1[xi,yi] = fct(deriv_fct1d(fct(var[xi,yi]),1),/inv,/sin)*(2.*!pi)/nper 
;        v1[xi,yi] = fct(filter_fct1d(deriv_fct1d(fct(var[xi,yi]),1)),/inv,/sin)*(2.*!pi)/nper 

;        v1[xi,yi] = DERIV(var[xi,yi])

;        v2[xi,yi] = SPL_INIT(yf,var[xi,yi])
;        v1[xi,yi] = SPLDER(yf,var[xi,yi],v2[xi,yi])


    ENDELSE
  ENDREP UNTIL last
  RETURN, v1 / dtheta
END
