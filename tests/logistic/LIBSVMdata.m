function str = LIBSVMdata(index)
!python tests/logistic/get_filenames.py
strs= get_LIBSVMdata();
str = strs{index};
end