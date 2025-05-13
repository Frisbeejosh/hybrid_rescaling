for file in ./*.vcf
do
iteration=$(basename "$file" .vcf)
/local/workdir/jbl256/Installed_programs/vcftools-0.1.16/bin/vcftools --vcf "$file" --window-pi 10000 --out "${iteration}_site_pi"

echo "finished site-pi on" $file

done

for file in ./*.windowed.pi
do
awk 'NR > 1 {print $5}' "$file" >> combined_nucleotide_diversity.csv

echo "adding" $file "to csv"

done

rm *.windowed.pi