# cmake-find-package
cmake scripts to find external packages

## Available packages

* [spdk](https://github.com/spdk/spdk)
* [spdk/dpdk](https://github.com/spdk/dpdk)
* [spdk/isa-l](https://github.com/spdk/isa-l)

## Usage

1. Copy this repository in your cmake project by `git clone`
2. Add the path of this directory to `CMAKE_MODULE_PATH`
3. You can use some variables defined by cmake config files in your build.
Example code is located in example directory.

```sh
$ cd example
$ mkdir build
$ cd build
$ cmake .. -DDPDK_ROOT_DIR=<dpdk-installed> -DSPDK_ROOT_DIR=<spdk-installed> -DISAL_LIB_DIR=<isal-libs> -DISAL_INCLUDE_DIR=<isal-include> -DCMAKE_PREFIX_PATH=.
```
