#!/bin/sh

_pwd="${PWD}"
_root="$(dirname "$(readlink -f "${0}")")"
echo "${_root}"
cd "${_root}" || exit

for d in */
do
    _name="${d%/}"
    cd "${_name}/src/${_name}" || exit
    dotnet lambda package
    mkdir -p ../../../../cdk-saga-orchestration/lambdas
    cp "bin/Release/net6.0/${_name}.zip" "../../../../cdk-saga-orchestration/lambdas"
    cd "${_root}" || exit
done

cd "${_pwd}" || exit