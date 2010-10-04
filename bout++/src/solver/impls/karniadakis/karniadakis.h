/**************************************************************************
 * Karniadakis split-operator solver
 *   J. Comput. Phys. 97 (1991) p414-443
 * 
 * Always available, since doesn't depend on external library
 * 
 * Solves a system df/dt = S(f) + D(f)
 * 
 * where S is the RHS of each equation, and D is the diffusion terms
 * 
 **************************************************************************
 * Copyright 2010 B.D.Dudson, S.Farley, M.V.Umansky, X.Q.Xu
 *
 * Contact: Ben Dudson, bd512@york.ac.uk
 * 
 * This file is part of BOUT++.
 *
 * BOUT++ is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * BOUT++ is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with BOUT++.  If not, see <http://www.gnu.org/licenses/>.
 *
 **************************************************************************/

class KarniadakisSolver;

#ifndef __KARNIADAKIS_SOLVER_H__
#define __KARNIADAKIS_SOLVER_H__

#include "mpi.h"

#include "bout_types.h"
#include "field2d.h"
#include "field3d.h"
#include "vector2d.h"
#include "vector3d.h"

#include "solver.h"

class KarniadakisSolver : public Solver {
 public:
  KarniadakisSolver();
  ~KarniadakisSolver();

  int init(rhsfunc f, int argc, char **argv, bool restarting, int nout, BoutReal tstep);
  
  int run(MonitorFunc f);
 private:
  
  BoutReal *f1, *f0, *fm1, *fm2; // System state at current, and two previous time points
  BoutReal *S0, *Sm1, *Sm2; // Convective part of the RHS equations
  BoutReal *D0;             // Dissipative part of the RHS
  
  BoutReal out_timestep; // The output timestep
  int nsteps; // Number of output steps
  
  BoutReal timestep; // The internal timestep
  BoutReal time; // The current time
  
  int nlocal; // Number of variables on local processor
  
  void take_step(BoutReal dt); // Take a single step to calculate f1
};

#endif // __KARNIADAKIS_SOLVER_H__
