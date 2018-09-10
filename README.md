# stempel data

This repository contains benchmark results obtained with the [
Stencil TEMPlate Engineering Library](https://github.com/RRZE-HPC/stempel "stempel").

## folder scheme

1. main folder: "stencils"
2. dimension: "3D" / "2D" ...
3. stencil radius: "1r" / "2r" ...
4. weighting factors: "isotropic" / "heterogeneous" / "homogeneous" / "point-symmetric"
5. stencil kind: "star" / "box"
6. coefficient type: "constant" / "variable"
7. datatype: "double" / "float"
8. machine name: "BroadwellEP_E5-2697" (a suitable machine file should exist)

For example:
```
stencils/3D/1r/isotropic/star/constant/double/BroadwellEP_E5-2697
```

### each folder contains (at least):
- results.csv: width all benchmark data
- stencil.c: (or similar name) stencil source code
