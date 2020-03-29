# HADDOCK_report
small scripts to generate reports in a HADDOCK directory (it0, it1, water).

the script makes some of the standard HADDOCK plots, plus uses Bio3d (http://thegrantlab.org/bio3d/index.php) to generate some additional analysis (PCA and other plots), to make a "report" on the HADDOCK run.

All preprocessing is taken care of by 

./preprocessing.sh

Then 

Rscript plot_haddock_run.r

Look at 


----------------


Run after having generated .stat files by

$HADDOCKTOOLS/ana_structures.csh

(see http://www.bonvinlab.org/education/HADDOCK24/HADDOCK24-local-tutorial/ )



All models need to have a single chain and unique residue numbering all the way through.
Please use Joao's PDB tools to make sure this is the case
https://github.com/JoaoRodrigues/pdb-tools


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
