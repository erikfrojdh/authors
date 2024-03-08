# # Linux Intel (x86_64):
# curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
# # Linux ARM64:
# curl -Ls https://micro.mamba.pm/api/micromamba/linux-aarch64/latest | tar -xvj bin/micromamba
# # Linux Power:
# curl -Ls https://micro.mamba.pm/api/micromamba/linux-ppc64le/latest | tar -xvj bin/micromamba
# # macOS Intel (x86_64):
# curl -Ls https://micro.mamba.pm/api/micromamba/osx-64/latest | tar -xvj bin/micromamba
# # macOS Silicon/M1 (ARM64):
# curl -Ls https://micro.mamba.pm/api/micromamba/osx-arm64/latest | tar -xvj bin/micromamba

CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate
CB := conda-not-found
HOST := $(shell hostname)
OSNAME := $(shell uname -s)
ifeq (${OSNAME}, Linux)
	OS := linux
else ifeq (${OSNAME}, Darwin)
	OS := osx
endif
ARCH := $(shell uname -m)


default: run

.bin/micromamba:
	mkdir -p .bin
	cp etc/.mambarc .bin/.mambarc
	curl -Ls https://micro.mamba.pm/api/micromamba/${OS}-${ARCH}/latest | tar -xv --strip-components=1 -C .bin bin/micromamba

.bin/envs/auth: .bin/micromamba
	.bin/micromamba --no-env -r ${PWD}/.bin create -f etc/environment.yml

clean :
	rm -rf .bin/

run : .bin/envs/auth
	.bin/envs/auth/bin/uvicorn names:app --port 8000 --reload --host ${HOST}

test :
	
	echo ${OS}-${ARCH}