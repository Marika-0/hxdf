cd $(dirname $0);

sh run_cpp.sh
printf "################################################################\n";
sh run_hl.sh
printf "################################################################\n";
sh run_java.sh
printf "################################################################\n";
sh run_lua.sh
printf "################################################################\n";
sh run_neko.sh
printf "################################################################\n";
sh run_php.sh
printf "################################################################\n";
sh run_python.sh