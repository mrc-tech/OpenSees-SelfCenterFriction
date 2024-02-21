# test uniaxialMaterial in OpenSEES


wipe
model BasicBuilder -ndm 2; # bidimensional model


# #################################### MATERIALS ####################################

set Kinitial 	1000;	# initial stiffness of the RSFJ before slip
set DeltaSlip	1;		# initial elastic deflection of the RSFJ before slip
set Kloading	100;	# loading stiffness of the RSF
set Beta		0.5;	# Ratio of Forward to Reverse Activation Stress/Force 

uniaxialMaterial SelfCenterFriction  1  $Kinitial  $DeltaSlip  $Kloading  $Beta


# #################################### NODES ####################################

node 1 0.0 0.0
node 2 0.0 0.0


# ################################## ELEMENTS ##################################

element zeroLength  1   1   2   -mat 1 -dir 1


# ################################## CONSTRAINTS ##################################

fix 1 1 1 1
fix 2 0 1 1

puts "Geometry generated."


# ###############################################################################
# ############################## CYCLIC ANALYSIS ################################
# ###############################################################################


# Use displacement control at node $controlNode for analysis:
set controlNode 2; # control node
# set maxDisp [list 1.0 3.0]; # maximum displacements
set maxDisp [list 1.0 2.0 3.0]; # maximum displacements
set incr 0.001; # displacement increment
set nodeDof 1; # controlled dof

# Define reference force:
pattern Plain 1 "Linear" { load $controlNode 1.0 0.0 0.0 }

# Define recorders:
recorder Node -file "_disp.out"  -node 2 -dof 1 disp
recorder Element -file "_force.out"  -ele 1 force


# Define analysis parameters:
system SparseGeneral -piv
test NormUnbalance 1.0e-9 10
numberer Plain
constraints Plain
algorithm Newton
integrator DisplacementControl 1 2 1; # dummy integrator
analysis Static


foreach x $maxDisp {
	# execute a cycle from zero to maxDisp, then to -maxDisp and return to zero
	set numSteps [expr int($x/$incr)]; # number of steps per quadrant
	integrator DisplacementControl $controlNode $nodeDof $incr
	analyze $numSteps
	integrator DisplacementControl $controlNode $nodeDof -$incr
	analyze [expr 2*$numSteps]
	integrator DisplacementControl $controlNode $nodeDof $incr
	analyze $numSteps
}


puts "Benchmark cyclic analysis done."


