#!/bin/sh
echo "gdb utility for afl-fuzz by The Saiyans"
ulimit -v 100000 2>/dev/null
ulimit -d 100000 2>/dev/null
if [ "$#" -lt "1" ]; then
	echo "Usage: $0 /path/to/tested_binary [...target params. ..]" 1>&2
	echo 1>&2
	exit 1
fi
GDB=gdb
BIN="$1"
DIR=gdb/cores
for cores in $DIR/id_*; do
	core=$(basename -- "$cores")
	core="${core%.*}"
	estack="$(cat gdb/stack_vals/$core.txt)"
	$GDB --batch -q --ex "core $cores" --ex "set logging file gdb/dump_logs/$core.txt" --ex 'set logging on' --ex "x/${estack}x \$rsp" --ex 'quit' "$BIN" 0</dev/null
done


