# Forked
Based upon [cmake_geant4](https://github.com/wdconinc/cmake_geant4) which installs Geant4. This example script has been modified to install CERN ROOT without admin to the local scratch disk where there is sufficient storage space at the University of Surrey.

# ROOT
[ROOT](https://root.cern/) is an OO data analysis framework used in many areas of physics.

# Synopsis

```
root_install.sh <version>
```

# Description

This script downloads and builds ROOT from the source distribution. It installs the resulting binaries in `/scratch/applications/root<version>`. 
Multiple versions can be installed next to each other, and the desired version can be loaded by sourcing the file `bin/geant4.sh`.

# Examples

```
./root_install.sh 6.08. 06

```

# License

This work is provided under the license described in the `LICENSE` file.
