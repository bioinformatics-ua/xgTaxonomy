#!/bin/bash
#
compressor_files_path="compressors_files/"
compressor_path="compressors/"

mkdir -p compressors_files
mkdir -p compressors

rm -rf compressors/*
rm -rf compressors_files/*

Cmix_Installation() {
    mkdir -p ${compressor_files_path}
    wget https://github.com/byronknoll/cmix/archive/refs/tags/v19.1.zip -P ${compressor_files_path}
    unzip ${compressor_files_path}/v19.1.zip 
    cd cmix-19.1/ 
    chmod +x cmix
    make
    pwd
    cp cmix "../${compressor_path}"
    cd ..
    mv cmix-19.1/ ${compressor_files_path}
}

Pufferfish_Installation() {
    #./pufferfish -i <input file> -o <output file> [-c] | [-d]
    cd $compressor_files_path
    git clone https://github.com/alexholehouse/pufferfish.git
    cd pufferfish
    ./install
    cd "../.."

}


MFCompress_Installation() {
    # ./compress fastq_file.fastq 
    cd $compressor_files_path
    git clone https://github.uconn.edu/sya12005/LFastqC
    cp LFastqC/compress "../${compressor_path}" 
    cd ".."
}

UHT_Installation() {
    cd $compressor_files_path
    git clone https://github.com/aalokaily/Unbalanced-Huffman-Tree
    cp Unbalanced-Huffman-Tree/dist/UHTL_compress/UHTL_compress "../${compressor_path}"
    cd ..
}

NAF_Installation() {
    # ennaf file.fa -o file.naf
    cd $compressor_files_path
    git clone --recurse-submodules https://github.com/KirillKryukov/naf.git
    cd naf && make && make test && sudo make install
    cp ennaf/ennaf "../../${compressor_path}"
    cd "../.."
}

NUHT_Installation() {
    cd $compressor_files_path
    git clone https://github.uconn.edu/sya12005/Non-Greedy-Unbalanced-Huffman-Tree-Compressor-for-single-and-multi-fasta-files.git
    cp Non-Greedy-Unbalanced-Huffman-Tree-Compressor-for-single-and-multi-fasta-files/Linux/NUHT_Compress "../${compressor_path}"
    cd "..";
}

conda install -y -c bioconda jarvis --yes
conda install -c bioconda geco3 --yes

Pufferfish_Installation;
MFCompress_Installation;
NAF_Installation;
UHT_Installation;
NUHT_Installation;
Cmix_Installation;
chmod +x compressor_path/*
