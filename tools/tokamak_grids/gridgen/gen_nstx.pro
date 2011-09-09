WINDOW, xsize=600, ysize=800

;g = read_neqdsk("efit/neqdsk")
;g = read_neqdsk("efit/g014220.00200")
g = read_neqdsk("JRT2011/NSTX/129032/g129032.00547")

rz_grid = {nr:g.nx, nz:g.ny, $  ; Number of grid points
                   r:REFORM(g.r[*,0]), z:REFORM(g.z[0,*]), $  ; R and Z as 1D arrays
                   simagx:g.simagx, sibdry:g.sibdry, $ ; Range of psi
                   psi:g.psi, $  ; Poloidal flux in Weber/rad on grid points
                   npsigrid:(FINDGEN(N_ELEMENTS(g.pres))/(N_ELEMENTS(g.pres)-1)), $ ; Normalised psi grid for fpol, pres and qpsi
                   fpol:g.fpol, $ ; Poloidal current function on uniform flux grid
                   pres:g.pres, $ ; Plasma pressure in nt/m^2 on uniform flux grid
                   qpsi:g.qpsi, $ ; q values on uniform flux grid
                   nlim:g.nlim, rlim:g.xlim, zlim:g.ylim} ; Wall boundary

settings = {nrad:516, npol:256, psi_inner:[0.85,0.95], psi_outer:1.015}
boundary = TRANSPOSE([[rz_grid.rlim], [rz_grid.zlim]])
mesh = create_grid(rz_grid.psi, rz_grid.r, rz_grid.z, settings, boundary=boundary, /strict, interp='pspline')
save, filename='nstx129032_00547_x516y256.mesh.sav', g, rz_grid, settings, boundary, mesh
process_grid, rz_grid, mesh, output='nstx129032_00547_x516y256.nc'

