; calculates x (psi) derivative for 2D variable
FUNCTION ddx2, psi, var
  s = SIZE(var, /dimensions)
  nx = s[0]
  ny = s[1]

  v1 = DBLARR(nx, ny)
  v2 = v1

  FOR i=0, ny-1 DO BEGIN
        v2[*,i] = SPL_INIT(psi[*,i],var[*,i])
        v1[*,i] = SPLDER(psi[*,i],var[*,i],v2[*,i])

;        v1[*,i] = DERIV(psi[*,i], var[*,i])
  ENDFOR
  RETURN, v1
END
