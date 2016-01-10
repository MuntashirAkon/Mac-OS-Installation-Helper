#!/bin/bash

echo "DSDT Extractor"
echo "By Muntashir Al-Islam"
echo "---------------------"

# check if already E/C/A/patched has DSDT.aml
cd ~/Downloads/

echo "Extractor will download essential files."

# download patchmatic.zip
if [ -f "patchmatic.zip" ]; then
    echo "patchmatic.zip already exists"
else
    curl -L https://bitbucket.org/RehabMan/os-x-maciasl-patchmatic/downloads/RehabMan-patchmatic-2015-0107.zip > patchmatic.zip
fi
# download iasl.zip
if [ -f "iasl.zip" ]; then
    echo "iasl.zip already exists"
else
    curl -L https://bitbucket.org/RehabMan/acpica/downloads/iasl.zip > iasl.zip
fi

unzip patchmatic.zip -d ACPI
unzip iasl.zip -d ACPI


cd ACPI

echo "Extracting ACPI tables..."
./patchmatic -extract
rm patchmatic
echo "Done."
echo "Renaming files..."
for file in *; do
    if [ $file = "iasl" ]; then
        echo -n ""
    else
        mv $file "$file.aml"
    fi
done

echo "Disassembling files..."

echo -e "External(_SB_.PCI0.PEG0.PEGP.SGPO, MethodObj, 2)\nExternal(_SB_.PCI0.LPCB.H_EC.ECWT, MethodObj, 2)\nExternal(_SB_.PCI0.LPCB.H_EC.ECRD, MethodObj, 1)\nExternal(_GPE.MMTB, MethodObj, 0)" > refs.txt
./iasl -da -dl -fe refs.txt *.aml
rm iasl refs.txt *.aml
echo -e "Done.\nYour DSDT/SSDTs are ready to be patched!"
echo "You will find them at ~/Downloads/ACPI"
exit
