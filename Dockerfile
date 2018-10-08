FROM ubuntu:16.04
LABEL maintainer=<herberthb12@gmail.com>

RUN apt update
RUN apt install -y build-essential subversion cmake ninja-build python-minimal wget

# PREPARE FOLDERS
RUN mkdir -p llvm/src
RUN mkdir -p llvm/release
RUN mkdir -p llvm/tmp/llvm600

WORKDIR /llvm/src

# DOWNLOAD SOURCES

## 6.0.0
RUN wget http://releases.llvm.org/6.0.0/llvm-6.0.0.src.tar.xz 
RUN wget http://releases.llvm.org/6.0.0/cfe-6.0.0.src.tar.xz
RUN wget http://releases.llvm.org/6.0.0/compiler-rt-6.0.0.src.tar.xz
RUN tar -xf llvm-6.0.0.src.tar.xz
RUN tar -xf cfe-6.0.0.src.tar.xz
RUN tar -xf compiler-rt-6.0.0.src.tar.xz
RUN mv llvm-6.0.0.src llvm600
RUN mv cfe-0.0.0.src llvm600/tools/clang
RUN mv compiler-rt-6.0.0.src/* llvm600/tools/clang/runtime/compiler-rt
RUN rm llvm-6.0.0.src.tar.xz
RUN rm cfe-6.0.0.src.tar.xz
RUN rm compiler-rt-6.0.0.src.tar.xz 


# BUILD 
WORKDIR /llvm/tmp/llvm600
RUN cmake /llvm/src/llvm600  -DCMAKE_INSTALL_PREFIX=/llvm/release/llvm600 \
    -G Ninja -DCMAKE_BUILD_TYPE:STRING=Release \
    -DLLVM_TARGETS_TO_BUILD:STRING=X86 -DWITH_POLY:BOOL=OFF \
    -DLLVM_ENABLE_PEDANTIC=OFF -DLLVM_ENABLE_PIC=ON -DLLVM_REQUIRES_RTTI:BOOL=TRUE \
     -DLLVM_INCLUDE_TESTS:BOOL=OFF \
    -DLLVM_INCLUDE_GO_TESTS=OFF -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_INCLUDE_DOCS=OFF \
    -DLLVM_BINDINGS_LIST=" "
RUN ninja install

RUN rm -rf /llvm/tmp

WORKDIR /
