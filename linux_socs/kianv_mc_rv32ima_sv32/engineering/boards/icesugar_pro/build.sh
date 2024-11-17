#rm -f soc.v
#ln -s soc_minimal.v soc.v
time (make -f Makefile clean &&  make -f Makefile && icesprog soc.bit)
