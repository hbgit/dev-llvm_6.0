# Docker File

This Dockerfile builds LLVM 6.0.0 container images to support map2check base
image docker adopting Ubuntu 16.04.

# Usage:
From gitclone:

``` bash
$ docker build -t hrocha/dev-llvm_6.0:first --no-cache -f Dockerfile .
```

It is adopting the source from:
- http://releases.llvm.org/6.0.0/llvm-6.0.0.src.tar.xz
- http://releases.llvm.org/6.0.0/cfe-6.0.0.src.tar.xz
- http://releases.llvm.org/6.0.0/compiler-rt-6.0.0.src.tar.xz
