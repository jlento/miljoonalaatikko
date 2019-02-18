## CloudCompare

### Description

[CloudCompare] is a  3D point cloud (and triangular  mesh) editing and
processing software.

Originally, it has been designed  to perform direct comparison between
dense  3D point  clouds. It  provides tools  for comparision  of point
clouds  as  well  as  comparison between  pointclouds  and  triangular
meshes.  Many  other  point   cloud  processing  algorithms  are  also
implemented  (registration,  resampling,  color/normal  vectors/scalar
fields   management,   statistics  computation,   sensor   management,
interactive  or  automatic  segmentation,  etc.) as  well  as  display
enhancement  tools  (custom  color   ramps,  color  &  normal  vectors
handling, calibrated pictures handling, OpenGL shaders, plugins, etc.)

The main purpose  of CloudCompare in Taito  is to serve as  a tool for
visualizing point cloud data.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 2.9.1

------------------------------------------------------------------------

### Usage

Cloud compare can be used after loading following modules:

`module load geo-env boost cloudcompare`

The  cloudcompare  module  provides  two  binaries,  CloudCompare  and
ccViewer. CloudCompare launches  the full software where  you can also
perform point cloud processing. ccViewer is a light weight viewer that
let's  you take  a  look at  your  pointclouds. To  open  a file  with
ccViewer:

`ccViewer pointcloud.laz`

See   CloudCompare  [manual]   for  further   usage  instructions   of
CloudCompare.

------------------------------------------------------------------------

### Discipline

Geosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [CloudCompare]: http://www.cloudcompare.org/
  [manual]: http://www.cloudcompare.org/doc/qCC/CloudCompare%20v2.6.1%20-%20User%20manual.pdf
