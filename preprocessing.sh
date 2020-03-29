#!/bin/csh

setenv PDBTOOLS /home/gandrea/scripts/pdb-tools/pdbtools

mkdir directory_backup

foreach i (`cat file.nam`)
echo "working on $i..."
cp $i directory_backup
python $PDBTOOLS/pdb_chain.py -A $i > a
python $PDBTOOLS/pdb_reatom.py a >b
rm a
python $PDBTOOLS/pdb_reres.py b > c
rm b
mv c $i
end
