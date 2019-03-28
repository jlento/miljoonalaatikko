#!/bin/bash
#SBATCH -p test
#SBATCH -t 10
#SBATCH -n 3
##SBATCH --cpus-per-task=2

export MPICH_ASYNC_PROGRESS=1

# Test async
#
# If running async + passive, the longer 4 second jobs should come in
# batches of three (the last group can be anything from 1 to 3).
#
# If async calls happen only when target calls some MPI call, then the output
# varies, but does not have batches of three, and the total runtime is longer
# because work stealing can only hapen when the slow task returns from
# system() call....

for ((i = 0; i < 23; i++)); do
    echo sleep $(( ((i+1)%3) * ((i+2)%3) * 2 ))'; echo "Rank ${SLURM_PROCID}, line '$i': $(date +%T)"'
done | srun -p test -t 1 -n 3 pexe


# Test performance
#
# Both should yield about the same times if async progress is not killing
# performance.
# In the bad case setting '#SBATCH --cpus-per-task=2' does help, but is not
# exactly efficient use of resources...

multinodeopts="--sshloginfile $(generate_pbs_nodefile)"

printf "${SLURM_SUBMIT_DIR}/pi 100000 > /dev/null\\n%.0s" {1..7} \
       > $TMPDIR/commands.txt

time parallel --gnu -j ${SLURM_NTASKS} ${multinodeopts} < ${TMPDIR}/commands.txt

time srun ${SLURM_SUBMIT_DIR}/pexe < ${TMPDIR}/commands.txt
