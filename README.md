small scripts to generate reports in a HADDOCK directory (it0, it1, water).

the script makes some of the standard HADDOCK plots, plus uses Bio3d (http://thegrantlab.org/bio3d/index.php) to generate some additional analysis (PCA and other plots), to make a "report" on the HADDOCK run.

1. Set the $PDBTOOLS variable in preprocessing.csh to point to the directory of Joao Rodrigues's PDB tools (download from https://github.com/JoaoRodrigues/pdb-tools)
2. set the sourcing of haddock_configure.csh in preprocessing.sh
3. make sure all R libraries in plot_haddock_run.r are installed AND that bio3d can see MUSCLE 

All preprocessing is taken care of by 

./preprocessing.sh

This will renumber the residues in your structures. Original files are stored in directory_backup

Then 

Rscript plot_haddock_run.r

Look at core.png and set an appropriate volume for the common core and then rerun, chaning the "myvol" parameter.
Other editable things: use or not SVD in PCA; cut the tree differently in the PCA-based clustering.

The Bio3d code is largely lifted from Bio3d tutorials.

---------------


Please note that FCC-based clustering more suitable for the usual HADDOCK run than rmsd-based.

------------

Bio3D: An R package for the comparative analysis of protein structures.  
Grant, Rodrigues, ElSawy, McCammon, Caves, (2006) Bioinformatics 22, 2695-2696 
( Abstract | PubMed | PDF ) 

Cyril Dominguez, Rolf Boelens and Alexandre M.J.J. Bonvin. HADDOCK: a protein-protein docking approach based on biochemical and/or biophysical information.
J. Am. Chem. Soc. 125, 1731-1737 (2003).

Rodrigues, J. P. G. L. M., Teixeira, J. M. C., Trellet, M. & Bonvin, A. M. J. J.
pdb-tools: a swiss army knife for molecular structures. bioRxiv (2018). 
doi:10.1101/483305
