; calculates x (psi) derivative for 2D variable
FUNCTION ddx, psi, var
  s = SIZE(var, /dimensions)
  nx = s[0]
  ny = s[1]

  dv = DBLARR(nx, ny)
  vspl=dv
  FOR i=0, ny-1 DO BEGIN
        vspl[*,i] = SPL_INIT(psi[*,i],var[*,i])
        dv[*,i] = SPLDER(psi[*,i],var[*,i],vspl[*,i])

;        dv[*,i] = DERIV(psi[*,i], var[*,i])

;    dv[*,i] = DERIV(psi[*,i], var[*,i])
  END
  RETURN, dv
END
