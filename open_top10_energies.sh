#!/bin/bash

grep energies *pdb | awk '{print $1, $3}' | sed 's/:REMARK//g' | sed 's/,//g' | sort -g -k2 | head | awk '{print $1}' | xargs pymol
