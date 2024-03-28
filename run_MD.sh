#!/bin/bash

export CUDA_VISIBLE_DEVICES=2
prmtop_file=complex.prmtop
rst7_file=complex.inpcrd

pmemd_cuda="/home/eric.chen/software/amber22/bin/pmemd.cuda"


###Minimization#####
date
${pmemd_cuda} -i min_1.in -p ${prmtop_file} -c ${rst7_file} -ref ${rst7_file} -O -o min_1.out -r min_1.rst7



#### Heating and Pressing gradually to 298.15 K and 1 ATM###

##Heating to 100K, and NPT equilibrium
${pmemd_cuda} -i heat_1.in -p ${prmtop_file} -c min_1.rst7 -ref min_1.rst7 -O -o heat_1.out -r heat_1.rst7 -x heat_1.nc

${pmemd_cuda} -i press_1.in -p ${prmtop_file} -c heat_1.rst7 -ref heat_1.rst7 -O -o press_1.out -r press_1.rst7 -x press_1.nc


##Heating to 200 K and NPT equilibrium
${pmemd_cuda} -i heat_2.in -p ${prmtop_file} -c press_1.rst7 -ref press_1.rst7 -O -o heat_2.out -r heat_2.rst7 -x heat_2.nc

${pmemd_cuda} -i press_2.in -p ${prmtop_file} -c heat_2.rst7 -ref heat_2.rst7 -O -o press_2.out -r press_2.rst7 -x press_2.nc



##Heating to 298.15K and NPT equilbrium

${pmemd_cuda} -i heat_3.in -p ${prmtop_file} -c press_2.rst7 -ref press_2.rst7 -O -o heat_3.out -r heat_3.rst7 -x heat_3.nc

${pmemd_cuda} -i press_3.in -p ${prmtop_file} -c heat_3.rst7 -ref heat_3.rst7 -O -o press_3.out -r press_3.rst7 -x press-3.nc


${pmemd_cuda} -i prod.in -p ${prmtop_file} -c press_3.rst7 -ref press_3.rst7 -O -o prod.out -r prod.rst7 -x prod.nc



