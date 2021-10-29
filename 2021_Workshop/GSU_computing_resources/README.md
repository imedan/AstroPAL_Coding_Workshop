# Accessing GSU Computing Resources

Through the astronomy department, you have access to many computing resources that you will most likely need to use at some point during your graduate career. At the beginning of your first year, you should be given login credentials that you can then use to access these resources either on campus or at home. Generally, to access the computing resources from your computer you can ssh into the network like:

	ssh username@joy.chara.gsu.edu

For the above, you will need to login to the [GSU VPN](https://technology.gsu.edu/technology-services/it-services/security/virtual-private-network/) to access the network. Otherwise you can provide a port number at login (ask J&J for this) like the follwing:

	ssh -p NNNNNN username@joy.chara.gsu.edu

Once on joy, you should login to your respective computer and **not do your work on joy**. Doing your work on joy will slow down the entire network and make logging in for others difficult. To do this, simply ssh to your domain once on joy using the following:

	ssh username@domain

If you are having trouble figuring out which domain you should be going to, you can check this by opening a terminal on the desktop you are assigned to. One here, feel free to start working! There should be versions of IDL, Python, IRAF, etc. already installed for you to use, though you can add newer versions/packages locally if you need to (discussed later).

# Transfering Files

Sometimes you may want to transfer code/files from your computer to your laptop though (or vice-versa). This is very easy to do with scp, like in the following:

	scp username@joy.chara.gsu.edu:~/path_to_file_on_joy ~/path_to_save_location_on_laptop/

Additionally, if you want to transfer an entire directory, you can do the following:

	scp -r username@joy.chara.gsu.edu:~/path_to_directory_on_joy/ ~/path_to_save_location_on_laptop/

Finally, if you write a piece of code, for example, on your laptop, you can transfer it to your computer as follows:

	scp ~/path_to_file_location_on_laptop username@joy.chara.gsu.edu:~/path_to_save_location_on_joy/

In all instances, remember that you will need to VPN to the GSU network or provide a port number (where the one change for scp is you provide the port number after -P instead of -p).

# Other Resources

In addition to the above resources, you also have access to High Performance Computing (HPC) nodes. Mainly, we have access to the [Galileo Cluster](https://physics-astro.gsu.edu/galileo-cluster-getting-started-guide/), which offers a few nodes with different computing capabilities. If you would like an account, you can request one [here](https://physics-astro.gsu.edu/galileo-cluster-account-request/). Note that accounts only last for a year, and a new one will have to be requested annually.

In the cluster, jobs are submitted using the Slurm command [sbatch](https://slurm.schedmd.com/sbatch.html). An example of a batch script named ``submit.sh`` that wants to run a Python script called ``amazing_code.py`` and write any outputs to ``res.txt`` would look like the following:

	#!/bin/bash
	#SBATCH --job-name amazing_code
	#SBATCH --output=res.txt
	#SBATCH --ntasks=1
	#SBATCH --time=02:00:00
	#SBATCH --cpus-per-task=8
	#SBATCH --partition=normal
	python3 -u amazing_code.py

To then submit the job to the cluster, you would run the following:

	sbatch submit.sh

To see the the progress of your job, you can run

	squeue

Note, that if you think your job will take longer than 12 hours, there is a ``longjobs`` partition that will run jobs for up to 72 hours.