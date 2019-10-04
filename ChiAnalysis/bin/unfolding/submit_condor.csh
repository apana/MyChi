#!/bin/tcsh

setenv theDate `date +"%Y%m%d"`
setenv CMSSW_BASE /uscms_data/d3/jingyu/ChiAnalysis/jetUnfold/CMSSW_7_3_6
setenv MC pythia8
setenv Binning Pt_170toInf
setenv smearing CB_AK4SF
setenv outputDir root://cmseos.fnal.gov//eos/uscms/store/user/zhangj/jetUnfold/GenNtuple/2017ReReco/pythia8_ci_CrystalBall

setenv Split 0 #  0=no split,1=train,2=test

cd $CMSSW_BASE/src

tar -zcvf ../../CMSSW736.tgz ../../CMSSW_7_3_6/ --exclude="*.root" --exclude="*.pdf" --exclude="*.gif" --exclude=.git  --exclude="*.log" --exclude="*.stdout" --exclude="*.stderr"

eosrm /store/user/zhangj/CMSSW736.tgz

xrdcp ../../CMSSW736.tgz root://cmseos.fnal.gov//store/user/zhangj/CMSSW736.tgz

cd $CMSSW_BASE/src/MyChi/ChiAnalysis/bin/unfolding

condor_submit condor.jdl
