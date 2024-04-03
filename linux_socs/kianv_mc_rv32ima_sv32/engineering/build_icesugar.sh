rm -f soc.v
ln -s soc_minimal.v soc.v
time (make -f Makefile.icesugar-pro clean &&  make -f Makefile.icesugar-pro  && icesprog soc.bit)
