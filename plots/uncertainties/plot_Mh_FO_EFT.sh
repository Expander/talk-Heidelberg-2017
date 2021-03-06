#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import scipy.interpolate

plt.rcParams['text.usetex'] = True
plt.rcParams['text.latex.preamble']=[r'\usepackage{amsmath}']

directory = r'plots/uncertainties/'

# plot Mh(MS)

outfile = directory + r'Mh_MS_TB-5_Xt-0_FO_EFT.pdf'

try:
    dataMSSMEFTHiggs = np.genfromtxt(directory + r'MSSMEFTHiggs_MS_TB-5_Xt-0..dat')
    dataMSSM         = np.genfromtxt(directory + r'scan_FeynHiggs-2.13.0beta_Mh_MS_TB-5_Xt-0.dat')
    dataSUSYHD       = np.genfromtxt(directory + r'HSSUSY_MS_TB-5_Xt-0..dat')
except:
    print "Error: could not load numerical data from file"
    exit

xMSSMEFTHiggs = dataMSSMEFTHiggs[:,0]
xMSSM         = dataMSSM[:,0]
xSUSYHD       = dataSUSYHD[:,0]

yMSSMEFTHiggs = dataMSSMEFTHiggs[:,1]
yMSSM         = dataMSSM[:,1]
ySUSYHD       = dataSUSYHD[:,1]

plt.rc('text', usetex=True)
plt.rc('font', family='serif', weight='normal')
fig = plt.figure(figsize=(4,4))
plt.gcf().subplots_adjust(bottom=0.15, left=0.15) # room for xlabel
ax = plt.gca()
ax.set_axisbelow(True)
ax.xaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
ax.yaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
plt.grid(color='gray', linestyle=':', linewidth=0.2)

plt.xscale('log')
plt.xlabel(r'$M_S\,/\,\mathrm{GeV}$')
plt.ylabel(r'$M_h\,/\,\mathrm{GeV}$')
plt.xlim([100,10000])

hMSSM, = plt.plot(xMSSM        , yMSSM        , 'b--', linewidth=1.2, label=r'2L fixed-order')
hEFT,  = plt.plot(xSUSYHD      , ySUSYHD      , 'g-.', linewidth=1.2, dashes=(5,3,1,3), label=r'2L EFT')

plt.legend(handles = [hMSSM, hEFT],
           loc='lower right', fontsize=10, fancybox=None, framealpha=None)

plt.title(r'$X_t = 0, \tan\beta = 5$', color='k', fontsize=10)

plt.savefig(outfile)
print "saved plot in ", outfile
plt.close(fig)
