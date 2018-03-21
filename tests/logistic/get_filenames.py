# -*- coding: utf-8 -*-
import glob
import os
import sys
preamble = 'tests/logistic/LIBSVM_data/'
os.chdir(preamble)

#Open all .cpp files in preamble folder
data_string = ' LIBSVMdata_files = { '
for file in glob.glob('*'):
  if not ('.t' in file) and not ('.bz2' in file):
     data_string = data_string + "'" +file + "'" + ','
data_string = data_string[:-1] + '};\n'

os.chdir('../')
wfile = open('get_LIBSVMdata.m','w')
wfile.write('function LIBSVMdata_files= get_LIBSVMdata() \n')
wfile.write(data_string)
wfile.write('LIBSVMdata_files = sort(LIBSVMdata_files); \n')
wfile.write('end')
wfile.close();	
