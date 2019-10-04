#!/bin/tcsh
echo "Starting job on " `date` #Date/time of start of job
echo "Running on: `uname -a`" #Condor job is running on this node
echo "System software: `cat /etc/redhat-release`" #Operating System on that node
source /cvmfs/cms.cern.ch/cmsset_default.csh  ## if a bash script, use .sh instead of .csh
xrdcp -s root://cmseos.fnal.gov//store/user/zhangj/CMSSW736.tgz .
tar -xf CMSSW736.tgz
rm CMSSW736.tgz
setenv SCRAM_ARCH slc6_amd64_gcc491
cd CMSSW_7_3_6/src
scramv1 b ProjectRename
eval `scramv1 runtime -csh` # cmsenv is an alias not on the workers
scramv1 b clean
scramv1 b 
cd MyChi/ChiAnalysis/bin/unfolding
rm -rf ../NtupleStruct_h*
env
cd RooUnfold
make clean
make
cd -
ls RooUnfold
ls ../NtupleStruct*
echo "Arguments passed to this script are: "
echo "  for 1: $1"
echo "  for 2: $2"
echo "  for 3: $3"
python ${1} -n 0 ${2} ${3}
cd ${_CONDOR_SCRATCH_DIR}
rm -rf CMSSW_7_3_6
