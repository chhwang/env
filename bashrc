# PATH registration
add-path() {
    local path=${1}
    if [ -d ${path} ] && [[ ":$PATH:" != *":${path}:"* ]]; then
        export PATH=${path}:${PATH}
    fi
}

# Docker
alias docker-run='docker run --privileged --ulimit memlock=-1:-1 --net=host --ipc=host -v $HOME:$HOME -it'
alias docker-run-nv='docker run --privileged --ulimit memlock=-1:-1 --net=host --ipc=host -v $HOME:$HOME -it --gpus all'
alias docker-run-amd='docker run --privileged --ulimit memlock=-1:-1 --net=host --ipc=host -v $HOME:$HOME -it --security-opt seccomp=unconfined --group-add video'

# CMake
get-cmake() {
    local version=${1:-3.26.4}
    local os=${2:-linux-x86_64}
    local file=cmake-${version}-${os}.tar.gz
    local url="https://github.com/Kitware/CMake/releases/download/v${version}/${file}"
    curl -L ${url} -o ${file}
    tar xzf ${file}
    rm ${file}
    add-path $(pwd)/cmake-${version}-${os}/bin
}

# OpenMPI
get-openmpi() {
    local version=${1:-4.1.5}
    local file=openmpi-${version}.tar.bz2
    local url="https://download.open-mpi.org/release/open-mpi/v4.1/${file}"
    curl -L ${url} -o ${file}
    tar xjf ${file}
    rm ${file}
    add-path $(pwd)/openmpi-${version}/bin
}
