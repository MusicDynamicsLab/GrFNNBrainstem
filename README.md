# GrFNNBrainstem
<img src="https://MusicDynamicsLab.github.io/Figures/brainstemModel.jpg" width="800">

Brainstem model using Gradient Frequency Neural Network (GrFNN) toolbox.

The script `brainstemPaper` sets up a four-layer parameterized brainstem network meant to replicate the network used in Lerud et al. (2014) as closely as possible. The script `brainstem` sets up a four-layer parameterzed brainstem network which is current with the latest <a href="https://github.com/MusicDynamicsLab/GrFNNCochlea">cochlea model</a>.

Neither of the brainstem scripts sets up a stimulus itself, so it will be up to the user to create one. However this repository also includes stimuli and scripts to replicate the FFR (frequency-following response) model from Lerud et al. The relevant user-facing script is `FFRmodel`, which reads in either of the two .wav files used in that paper, and sets them up for alternating polarity. Of course the user can replace these stimuli with their own. `brainstemPaper` is eventually called as the basis for this FFR model. 

<a href="http://musicdynamicslab.uconn.edu/wp-content/uploads/sites/433/2016/02/Lerud2014Hearing-Research-2PubsAHEdits.pdf">Lerud, K. D., Almonte, F. V., Kim, J. C., and Large, E. W. (2014). “Mode-locking neurodynamics predict human auditory brainstem responses to musical intervals.” Hearing research 308, 41–9.</a>
