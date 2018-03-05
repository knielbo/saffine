import numpy as np
import multi_detrending as md
from acoustics.generator import noise

import matplotlib as mpl
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1.inset_locator import inset_axes

import warnings
warnings.filterwarnings('ignore')

def difference(l, interval = 1):
    """ difference list
    """
    diff = list()
    for i in range(interval, len(l)):
        val = l[i] - l[i - interval]
        diff.append(val)
    return diff

# parameters
n = 500
step_size = 1
q = 2
order = 1
XY = []
FBM = []
FWN = []

#colors = ['white', 'white','pink','brown']
colors = ['white', 'white','pink']
process_label = ['$Anti$-$persistent$ $process$','$Short$-$range$ $correlations$','$Persistent$ $process$']

for i, c in enumerate(colors):
    fwn = noise(n, color = c)
    # create some colored fBm data
    if i == 0:
        fbm = np.mat(fwn) + (np.mat(np.cumsum(fwn)-np.mean(fwn)))/5
    else:
        fbm = np.mat(np.cumsum(fwn)-np.mean(fwn))
    uneven = fbm.shape[1]%2
    if uneven:
        fbm = fbm[0,:-1]
    # AFA step
    XY.append(md.multi_detrending(fbm,step_size,q,order))
    FBM.append(fbm)
    FWN.append(fwn)

FWN[0] = difference(FWN[0], interval = 1)

### pre-specify number of subplots
fig, ax = plt.subplots(len(colors),2)
fig.set_size_inches(16,len(colors)*6)
fig.subplots_adjust(wspace = .35, hspace = .35)

# customize fonts
mpl.rcParams.update({# Use mathtext, not LaTeX
                            'text.usetex': False,
                            # Use the Computer modern font
                            'font.family': 'serif',
                            'font.serif': 'cmr10',
                            #'font.serif': 'Times New Roman',
                            'font.weight':'bold',
                            'mathtext.fontset': 'cm',
                            })

mpl.rcParams['axes.linewidth'] = 2

for i, xy in enumerate(XY):
    # variables
    ## ts
    fBm = np.squeeze(np.asarray(FBM[i]))
    fWn = np.squeeze(np.asarray(FWN[i]))
    ## AFA
    x = np.squeeze(np.asarray(XY[i][0]))
    y = np.squeeze(np.asarray(XY[i][1]))
    ## fit
    p = np.poly1d(np.polyfit(x, y, order))
    xp = np.linspace(0, len(x), len(x))

    # plot ts
    ax[i,0].plot(fWn, color = 'k')
    #ax[i,0].plot(fBm, color = 'r')
    if process_label:
        ax[i,0].set_title(process_label[i], size = 25)
    else:
        ax[i,0].set_title('Integrated {} noise'.format(colors[i]), size = 25)
    ax[i,0].set_xlabel('$x$', size = 20)
    ax[i,0].set_ylabel('$F(x)$', size = 20)
    # aesthetics
    [i.set_linewidth(2.25) for i in ax[i,0].spines.values()]# border
    ax[i,0].tick_params(axis='both', which='both', labelsize = 15)

    # fWn distribution inset
    ## determine best rightmost location for inset
    if np.mean(fWn[-150:]) > np.mean(fWn):
        loc = 4
    else:
        loc = 1
    fWnDist = inset_axes(ax[i,0],
                    width="25%",
                    height=.75,
                    loc=loc)
    n, bins, patches = plt.hist(fWn, 25, normed=1, edgecolor = 'w', facecolor = 'k')
    plt.xticks([])
    plt.yticks([])

    # plot fit
    ax[i,1].plot(xp, p(xp), 'k-', linewidth = 2,zorder = 0)
    ax[i,1].scatter(x, y, c = 'r', s = 100, zorder = 1)

    ax[i,1].set_title('$H = {}$'.format(round(np.polyfit(x, y, 1)[0],2)), size = 25)
    ax[i,1].set_xlabel('$Log(w)$', size = 20)
    ax[i,1].set_ylabel('$LogF(w)$', size = 20)
    print(p)

    # aesthetics
    [i.set_linewidth(2.25) for i in ax[i,1].spines.values()]# border
    ax[i,1].tick_params(axis='both', which='both', labelsize = 15)

#plt.tight_layout()
plt.savefig('colored_noise.png')
plt.close()
