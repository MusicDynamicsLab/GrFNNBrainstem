# GrFNNBrainstem
<img src="https://MusicDynamicsLab.github.io/Figures/brainstemModel.jpg" width="800">

Brainstem model using Gradient Frequency Neural Network (GrFNN) toolbox.

This repository contains code to use an oscillatory model of the auditory periphery and brainstem. The first two layers of oscillators represent a gradient of center frequencies within the cochlea. The next layer represents the cochlear nucleus, which is the first synapse of the auditory system and already exhibits many interesting nonlinear properties, including <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2887620/">mode-locking</a>. The fourth layer of this model represents another important part of the auditory brainstem, the inferior colliculus. This site is known to code for both temporal fine structure and envelope modulation. It is also believed to be an important area for the perception of pitch, as well as a potential generating site of the FFR (frequency-following response) in response to periodic stimuli. These and other aspects of the auditory brainstem are well accounted for in the GrFNN model contained in this repository.

The script `brainstemPaper` sets up a four-layer parameterized brainstem network meant to replicate the network used in Lerud et al. (2014) as closely as possible. The script `brainstem` sets up a four-layer parameterzed brainstem network which is current with the latest <a href="https://github.com/MusicDynamicsLab/GrFNNCochlea">cochlea model</a>.

Neither of the brainstem scripts sets up a stimulus itself, so it will be up to the user to create one. However this repository also includes stimuli and scripts to replicate the FFR model from Lerud et al. The relevant user-facing script is `FFRmodel`, which reads in either of the two .wav files used in that paper, and sets them up for alternating polarity. Of course the user can replace these stimuli with their own. `brainstemPaper` is eventually called as the basis for this FFR model. 

<a href="http://musicdynamicslab.uconn.edu/wp-content/uploads/sites/433/2016/02/Lerud2014Hearing-Research-2PubsAHEdits.pdf">Lerud, K. D., Almonte, F. V., Kim, J. C., and Large, E. W. (2014). “Mode-locking neurodynamics predict human auditory brainstem responses to musical intervals.” Hearing research 308, 41–9.</a>
