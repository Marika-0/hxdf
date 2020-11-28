cd $(dirname $0)/hxtf;

haxelib run hxtf -f -t 0 \
    jvm_dceNo \
    jvm_dceStd \
    jvm_dceFull \
    jvm_optNo \
    jvm_optFull \
