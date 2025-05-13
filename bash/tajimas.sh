for file in ./*.vcf
do
iteration=$(basename "$file" .vcf)
/local/workdir/jbl256/Installed_programs/vcftools-0.1.16/bin/vcftools --vcf "$file" --TajimaD 10000 --out "${iteration}_tajimaD"

echo "finished TajimaD on" $file

done

for file in ./*.Tajima.D
do
awk 'NR > 1 {print $4}' "$file" >> combined_tajima.csv

echo "adding" $file "to csv"

done

rm *.Tajima.D