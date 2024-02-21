# OpenSees-SelfCenterFriction
Self-center friction-based constitutive model

# **The code will be added if the article will be accepted for publication**

## Usage (TLC):
Include [`SelfCenterFriction.dll`](https://github.com/mrc-tech/OpenSees-SelfCenterFriction/releases/latest/download/SelfCenterFriction.dll) file inside the same folder of the TCL model file to use the material. The material can be defined by the TCL command:
```tcl
uniaxialMaterial SelfCenterFriction  $matTag  $k $us $k1 $beta
```
| parameter | description |
| --- | --- |
| `matTag` | integer tag identifying the material |
| `k` | initial stiffness |
| `us` | slip displacement |
| `k1` | loading slip stiffness |
| `beta` | ratio of residual to slip force $\beta=\frac{F_{res}}{F_y}$ |
