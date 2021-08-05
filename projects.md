---
title: Projects
---

Following is a list of projects I am currently working on, or have
worked on in the past. Where possible, I have included links to the
Github repository, published/unpublished papers and the project
website.

The project website can be consulted to get a broad overview of the
project whilst the papers can be read if one wishes for more depth on
the matter. I usually host my projects on Github, the README can be
consulted to get familiar with the structure of the repository.

# [2021] aocp.el

*elisp*

An emacs package to manage bibliographic information in org-mode (a
major mode for Emacs).

[[Github](https://github.com/arumoy-shome/aocp.el)]

# [2020] KM3NeT

*Python, Pytorch, Pytorch Geometric*

Neutrinos are highly elusive subatomic particles which can only be
detected with the help of large particle detectors. The KM3NeT
neutrino telescope is one such detector currently being constructed at
the bottom on the Mediterranean Sea. Due to its large volume and the
presence of background noise, `event trigger` algorithms are utilized
by the data acquisition pipeline of the detector to sift through the
noise. A GPU Pipeline was also developed to improve the quality of
filtration of the event trigger algorithms without compromising their
runtime performance. Despite these efforts, the quality of filtration
require further improvements. The goal of this paper is to improve
upon the GPU Pipeline using Artificial Neural Networks. The paper
explores the possibility of replacing parts of the GPU Pipeline using
Multi Layer Perceptrons and Graph Convolutional Neural Networks. The
Multi Layer Perception performs better compared to the existing
solution while the results of the Graph Convolutional Network are
inconclusive in its existing form. Overall, the outcome is promising
and new avenues of research are discovered through this work.

[[Github](https://github.com/arumoy-shome/km3net)][[Paper](assets/pdf/km3net.pdf)]

# [2020] Privacy Preserving Deep Learning for Medical Imaging

*Latex*

The success of Deep Neural Networks with image classification prompted
researchers to explore the applications of Deep Learning in Medical
Imaging and Medical Image Analysis (MIA). Deep Neural Networks have
sufficiently demonstrated their capabilities of performing MIA tasks
tirelessly and with fewer errors as opposed to their human
counterpart. However the challenge of training neural networks using
sensitive medical data, without violating the privacy of patients
remains an active field of research. Many solutions exist to address
this concern, however a systematic review and analysis of these
techniques is yet to be conducted. This paper attempts to conduct the
first systematic review of privacy-preserving techniques to train deep
learning models. Emphasis is especially put on the performance and
privacy analysis of the techniques. In addition, the communication and
runtime costs, the ability of the solutions to scale, tolerance to
faults and the level of security against threats and attacks are also
studied.

[[Paper](assets/pdf/ppdl.pdf)]

# [2020] vim-zettel

*Vimscript*

A (neo)vim plugin to manage plain text notes, inspired by Niklas
Luhmann's [Zettelkasten](https://en.wikipedia.org/wiki/Zettelkasten)
technique.

[[Github](https://github.com/arumoy-shome/vim-zettel/)]

# [2020] vim-text-lists

*Vimscript*

A (neo)vim plugin that provides utility functions for working with
plain text lists.

[[Github](https://github.com/arumoy-shome/vim-text-lists)]

# [2019] ACE: Art, Color and Emotions

*JavaScript, D3.js*

Art has been the cornerstone of human expression and social progress
through time. It is no wonder that art historians and daily
enthusiasts alike have spent countless hours trying to understand more
than what meets the eye. What an individual can draw from a painting
is very subjective, but we now know that human mind has a high
sensibility for well-defined subset of traits - one of them being
colour. This paper describes the process of bringing a new light on
how colours and emotional tone (sentiment) can be interlaced with one
another. This is achieved with the use of widespread artificial
intelligence techniques, a vast dataset of art meta-data(OmniArt) and
state-of-the-art visual interaction tools.

[[Paper](assets/pdf/ace.pdf)][[Publication](https://dl.acm.org/doi/abs/10.1145/3343031.3350588)]

# [2018] 3D Kadaster

*Python, Apache Spark, Three.js*

We created a 3D model of all the buildings in The Netherlands using
point cloud dataset.

[[Paper](assets/pdf/kadaster.pdf)][[Demo](https://arumoy.me/3d-kadaster)]

# [2018] Knowledge Acquisition from CommonCrawl

*Python, NLTK, Stanford NLP*

We applied a complete knowledge acquisition pipeline to WARC datasets
using Natural Language Processing, Part of Speech tagging, Named
Entity Recognition and Entity Linking. We also proposed a novel idea
to improve entity retrieval using machine learning.

[[Paper](assets/pdf/wdp.pdf)]

# [2017] Elevate

*JavaScript, Phaser.io*

Specialized educational resources for individuals with Down Syndrome
are lacking. This problem space was explored in detail through surveys
and interviews with both the primary and secondary users. Several
problems were discovered in this space of which, the lack of an
affordable, easy to use and engaging cognitive test was deemed
critical. This problem was further explored and an improved form of
this assessment using web based games was proposed. The design process
was broken down into three iterative phases. The first was defining
the problem, followed by validating the solutions and finally
iterating on the final solution. Throughout the phases, five main
approaches were used to help with the analysis and iterative process.
The approaches included user surveys, user Interviews, Wizard of Oz
testing, usability testing, and user testing. Engagement, key
usability issues and scoring correlation with standard methods were
the primary testing protocols used for validation of the final
designed solution. The results and limitations of the designed
solution are touched upon and a few reasonable next steps are laid
upon for the future.

[[Paper](assets/pdf/elevate.pdf)][[Github](https://github.com/arumoy-shome/elevate)][[Website](https://arumoy.me/elevate)]
