cd $(dirname $0);

sh test_cpp.sh;
cpp_status=$?;
printf "################################################################\n";

sh test_hl.sh;
hl_status=$?;
printf "################################################################\n";

sh test_java.sh;
java_status=$?;
printf "################################################################\n";

sh test_lua.sh;
lua_status=$?;
printf "################################################################\n";

sh test_neko.sh;
neko_status=$?;
printf "################################################################\n";

sh test_php.sh;
php_status=$?;
printf "################################################################\n";

sh test_python.sh;
python_status=$?;
printf "################################################################\n";

if [[ $cpp_status == 0 && $hl_status == 0 && $java_status == 0 && $lua_status == 0 && $neko_status == 0 && $php_status == 0 && $python_status == 0 ]];
then
    printf "\n  All tests passed!\n\n";
else
    printf "\n  The following targets failed testing$cpp_status:\n";
    if [[ $cpp_status != 0 ]]; then    printf "    C++\n"; fi;
    if [[ $hl_status != 0 ]]; then     printf "    HashLink\n"; fi;
    if [[ $java_status != 0 ]]; then   printf "    Java\n"; fi;
    if [[ $lua_status != 0 ]]; then    printf "    Lua\n"; fi;
    if [[ $neko_status != 0 ]]; then   printf "    Neko\n"; fi;
    if [[ $php_status != 0 ]]; then    printf "    PHP\n"; fi;
    if [[ $python_status != 0 ]]; then printf "    Python\n"; fi;
    printf "\n";
fi
