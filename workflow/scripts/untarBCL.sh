#!/bin/bash
#untarBCL.sh
#*
#* --------------------------------------------------------------------------
#* Licensed under MIT (https://git.biohpc.swmed.edu/BICF/Astrocyte/cellranger_mkfastq/blob/develop/LICENSE)
#* --------------------------------------------------------------------------
#*

usage() {
  echo "-t  --tar file"
  exit 1
}
OPTIND=1
while getopts :t: opt
do
  case ${opt} in
	t) tar=${OPTARG};;
  esac
done

shift $((${OPTIND} -1))

folder=$(tar -tf ${tar} | grep -o "^[^/]*/\$")
folder1=$(echo "$folder" | tr -d ' ')

if [ "${folder}" != "${folder1}" ]; then
  echo "Error: Spaces found in BCL Directory Path"
  echo ${folder}
  exit 21
fi

name=$(echo ${tar} | rev | cut -f1 -d '.' | rev)

if [ "${name}" == "gz" ]; then 
  tar -xvf ${tar} -I pigz
  else tar -xvf ${tar}
fi