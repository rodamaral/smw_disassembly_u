#!/bin/sh
exec watchexec -w . -e asm,inc -- make all