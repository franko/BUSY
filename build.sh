CC="${CC:-gcc}"
CFLAGS="${CFLAGS:--O2}"
LDFLAGS="${LDFLAGS:--O2}"

if [[ $OSTYPE == msys || $OSTYPE == win32 ]]; then
    busy_exe=busy-lua.exe
else
    busy_exe=busy-lua
fi

sources=(
    bshost.c
    bslex.c
    bslib.c
    bsparser.c
    bsrunner.c
    bsunicode.c
    lapi.c
    lauxlib.c
    lbaselib.c
    lcode.c
    ldblib.c
    ldebug.c
    ldo.c
    ldump.c
    lfunc.c
    lgc.c
    linit.c
    liolib.c
    llex.c
    lmathlib.c
    lmem.c
    loadlib.c
    lobject.c
    lopcodes.c
    loslib.c
    lparser.c
    lstate.c
    lstring.c
    lstrlib.c
    ltable.c
    ltablib.c
    ltm.c
    lua.c
    lundump.c
    lvm.c
    lzio.c
    print.c
)

log () {
    echo "$@"
    "$@"
}

objs=()
for source_name in "${sources[@]}"; do
    log $CC $CFLAGS -c $source_name &
    objs+=("${source_name/%.c/.o}")
done
wait

log $CC $LDFLAGS -o "$busy_exe" "${objs[@]}" -lm
